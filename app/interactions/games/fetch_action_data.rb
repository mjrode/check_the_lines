class Games::FetchActionData < Less::Interaction
  expects :sport
  expects :week, allow_nil: true

  def run
    url = construct_url
    games = Common::FetchJSON.run(url: url, auth_token: auth_token)['games']
    fetch_and_save_action_data(games) if games
  end

  private

  def construct_url
    url = "https://api.actionnetwork.com/web/v1/sharpreport/#{format_sport}bookIds=15"
    url = url + "&week=#{week}" if week
    puts url
    url
  end
  
  def format_sport
    case sport
    when 'cf'
      'ncaaf?'
      # 'ncaaf?division=FBS'
    when 'cb'
      # 'ncaab?division=D1'
      'ncaab?'
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
      away_team_name:         team_name(game, 'away')      ,
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
      num_bets:               num_bets(game),
      home_contrarian:        value_stats(game, 'home', 'Contrarian'),
      away_contrarian:        value_stats(game, 'away', 'Contrarian'),
      home_rlm:               value_stats(game, 'home', 'Rlm'),
      away_rlm:               value_stats(game, 'away', 'Rlm'),
      away_steam:             value_stats(game, 'away', 'Steam'),
      home_steam:             value_stats(game, 'home', 'Steam'),
      home_overall_rating:    value_stats(game, 'home', 'Overall'),
      away_overall_rating:    value_stats(game, 'away', 'Overall'),
      home_team_logo:         team_logo(game, 'home'),
      away_team_logo:         team_logo(game, 'away'),
      home_team_abbr:         team_abbr(game, 'home'),
      away_team_abbr:         team_abbr(game, 'away')
    }
  end
  
  def save_game(game_hash)
    game = WunderGame.where(external_id: game_hash[:external_id]).first_or_create
    game.update(game_hash)
  end
  
  def value_stats(game, home_or_away, stat)
    home_or_away_stats = game["#{home_or_away}_sharpreport"] || game["value_stats"][0]["#{home_or_away}_value_breakdown"]
    stat = home_or_away_stats.select {|hash| hash.has_value?(stat)}
    stat.first['value'] if stat.present?
  end
  
  def game_over(game)
    game['status'] == 'complete'
  end
  
  def team_name(game, home_or_away)
    team_id = game["#{home_or_away}_team_id"]
    team = game['teams'].select{|team| team['id'] == team_id}
    team.first['full_name']
  end
  
  def team_logo(game, home_or_away)
    team_id = game["#{home_or_away}_team_id"]
    team = game['teams'].select{|team| team['id'] == team_id}
    team.first['logo']
  end
  
  def team_abbr(game, home_or_away)
    team_id = game["#{home_or_away}_team_id"]
    team = game['teams'].select{|team| team['id'] == team_id}
    team.first['abbr']
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
  
  def auth_token
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6InU9NzM1ODI2dD0xNTY5NjgzNzI0OTUwIiwidXNlcl9pZCI6NzM1ODI2LCJpc3MiOiJzcG9ydHNBY3Rpb24iLCJhZ2VudCI6Ik1vemlsbGEvNS4wIChNYWNpbnRvc2g7IEludGVsIE1hYyBPUyBYIDEwXzExXzYpIEFwcGxlV2ViS2l0LzUzNy4zNiAoS0hUTUwsIGxpa2UgR2Vja28pIENocm9tZS83Ni4wLjM4MDkuMTMyIFNhZmFyaS81MzcuMzYiLCJpc1Jlc2V0VG9rZW4iOmZhbHNlLCJpc1Nlc3Npb25Ub2tlbiI6ZmFsc2UsInNjb3BlIjpbXSwiZXhwIjoxNjAxMjE5NzI0LCJpYXQiOjE1Njk2ODM3MjR9.KrzLmkZ0Q7enzNqc5kwIXaJoAScRJAIBIjIrLaIw8z4'
  end
end
