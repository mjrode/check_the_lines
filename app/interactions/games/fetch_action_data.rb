class Games::FetchActionData < Less::Interaction
  expects :sport

  def run
    url = construct_url
    games = Common::FetchJSON.run(url: url)['games']
    binding.pry
    fetch_and_save_action_data(games)
  end

  private

  def construct_url
    "https://api.actionnetwork.com/web/v1/sharpreport/#{sport}"
  end

  def fetch_and_save_action_data(games)
    games.each do |game|
      create_instance_variables(game)
      save_game
    end
  end
  
  def create_instance_variables(game)
    @away_team_name        = team_name(game, 'away')
    @home_team_name        = team_name(game, 'home')
    @away_team_ats_percent = ats_percent(game, 'away')
    @home_team_ats_percent = ats_percent(game, 'home')
    @away_team_ml_percent  = ml_percent(game, 'away')
    @home_team_ml_percent  = ml_percent(game, 'home')
    @over_percent          = total_percent(game, 'over')
    @under_percent         = total_percent(game, 'over')
    @game_time             = game['start_time']
    @game_date             = Date.parse(@game_time)
    @home_team_vegas_line  = vegas_line(game, 'home')
    @away_team_vegas_line  = vegas_line(game, 'away')
    @vegas_over_under      = odds_for_game(game)['total']
    @external_id           = game['id']
    @game_over             = game_over
    @away_team_final_score = final_score(game, 'away') if game_over
    @home_team_final_score = final_score(game 'home') if game_over
  end

  def game_hash
    {
      away_team_name:         @away_team_name,
      away_team_ats_percent:  @away_team_ats_percent,
      away_team_ml_percent:   @away_team_ml_percent,
      over_percent:           @over_percent,
      home_team_name:         @home_team_name,
      home_team_ats_percent:  @home_team_ats_percent,
      home_team_ml_percent:   @home_team_ml_percent,
      under_percent:          @under_percent,
      home_team_vegas_line:   @home_team_vegas_line,
      away_team_vegas_line:   @away_team_vegas_line,
      vegas_over_under:       @vegas_over_under,
      sport:                  sport,
      game_time:              @game_time,
      game_date:              @game_date,
      external_id:            @external_id,
      away_team_final_score:  @away_team_final_score,
      game_over:              @game_over,
      home_team_final_score:  @home_team_final_score
    }
  end
  
  def save_game
    game = WunderGame.find_or_initialize_by(external_id: @external_id)
    game.update(game_hash)
  end
  
  def game_over(game)
    game['status'] == 'complete'
  end
  
  def team_name(game, home_or_away)
    team_id = game["#{home_or_away}_team_id"]
    game['teams'][team_id]['full_name']
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
    odds_for_game(game)["spread_#{home_or_away}_line"]
  end
  
  def final_score(game, home_or_away)
    game['boxscore']["total_#{home_or_away}_points"]
  end
end
