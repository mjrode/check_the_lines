class Games::FetchActionData < Less::Interaction
  expects :sport

  def run
    url = construct_url
    games = Common::FetchJSON.run(url: url)['games']
    fetch_and_save_action_data(games)
  end

  private

  def construct_url
    "https://api.actionnetwork.com/web/v1/scoreboard/#{format_sport}&bookIds=15"
  end
  
  def format_sport
    case sport
    when 'cf'
      'ncaaf?division=FBS'
    when 'cb'
      'ncaab?division=D1'
    else
      sport + '?'
    end
  end

  def fetch_and_save_action_data(games)
    games.each do |game|
     if game['odds']
       game_hash = set_game_hash(game)
       save_game(game_hash)
     end
    end
  end
  
  def set_game_hash(game)
    {
      away_team_name:         team_name(game, 'away'),
      away_team_ats_percent:  ats_percent(game, 'away'),
      away_team_ml_percent:   ml_percent(game, 'away'),
      over_percent:           total_percent(game, 'over'),
      home_team_name:         team_name(game, 'home'),
      home_team_ats_percent:  ats_percent(game, 'home'),
      home_team_ml_percent:   ml_percent(game, 'home'),
      under_percent:          total_percent(game, 'under'),
      home_team_vegas_line:   vegas_line(game, 'home'),
      away_team_vegas_line:   vegas_line(game, 'away'),
      vegas_over_under:       odds_for_game(game)['total'],
      sport:                  sport,
      game_time:              game['start_time'],
      game_date:              Date.parse(game['start_time']),
      external_id:            game['id'],
      away_team_final_score:  final_score(game, 'away'),
      game_over:              game_over(game),
      home_team_final_score:  final_score(game, 'home'),
      num_bets:               num_bets(game)
    }
  end
  
  def save_game(game_hash)
    game = WunderGame.where(external_id: game_hash[:external_id]).first_or_create
    game.update(game_hash)
  end
  
  def game_over(game)
    game['status'] == 'complete'
  end
  
  def team_name(game, home_or_away)
    team_id = game["#{home_or_away}_team_id"]
    team = game['teams'].select{|team| team['id'] == team_id}
    team.first['full_name']
  end
  
  def odds_for_game(game)
    game['odds'].select{|odds| odds['type'] == 'game'}.first
  end
  
  def ats_percent(game, home_or_away)
    odds_for_game(game)["spread_#{home_or_away}_public"]
  end
  
  def ml_percent(game, home_or_away)
    odds_for_game(game)["ml_#{home_or_away}_public"]
  end
  
  def total_percent(game, over_or_under)
    odds_for_game(game)["total_#{over_or_under}_public"]
  end

  def vegas_line(game, home_or_away)
    odds_for_game(game)["spread_#{home_or_away}"]
  end
  
  def final_score(game, home_or_away)
    game_over(game) ? game['boxscore']["total_#{home_or_away}_points"] : nil
  end
  
  def num_bets(game)
    odds_for_game(game)['num_bets']
  end
end
