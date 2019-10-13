class Games::CreateGameRecord < Less::Interaction
  expects :process_all_games, allow_nil: true

  def run
    process_massey_and_action_data
  end

  private

  def process_massey_and_action_data
    games_to_process = process_all_games ? ActionGame.all : ActionGame.where(game_over: false)

    games_to_process.each do |action_game|
      home_team_name = action_game.home_team_name
      away_team_name = action_game.away_team_name

      massey_game = MasseyGame.where("sport = ?", action_game.sport).where(game_date: (action_game.game_date - 5.days)..(action_game.game_date + 5.days)).where(home_team_name: home_team_name, away_team_name: away_team_name).first
      # puts "Could not find an action match for massey game #{massey_game.away_team_name} vs #{massey_game.home_team_name}" if action_game.nil?

      pred_game = PredGame.where("sport = ?", action_game.sport).where(date: (action_game.game_date - 5.days)..(action_game.game_date + 5.days) ).where(home_team: home_team_name, away_team: away_team_name).first
      # puts "Could not find a prediction match for massey game #{massey_game.away_team_name} vs #{massey_game.home_team_name}" if action_game.nil?

      game = find_or_create_game(action_game)
      save_or_update_game(game, massey_game, action_game, pred_game)
    end
  end

  def find_or_create_game(action_game)
    Game.find_or_initialize_by(
      sport: action_game.sport,
      external_id: action_game.external_id,
      home_team_name: action_game.home_team_name,
      away_team_name: action_game.away_team_name,
    )
  end

  def set_game_time(action_game)
    action_game.game_over ? 'Final' : action_game.start_time.to_time.strftime("%I:%M %p")
  end

  def save_or_update_game(game, massey_game, action_game, pred_game)
    game_hash =
      {
        external_id: action_game.external_id,
        sport: action_game.sport,
        date: action_game.start_time,
        time: set_game_time(action_game),
        home_team_name: action_game.home_team_name,
        away_team_name: action_game.away_team_name,
        home_team_vegas_line: (action_game.home_team_vegas_line || massey_game.home_team_vegas_line),
        away_team_vegas_line:   (action_game.away_team_vegas_line || massey_game.away_team_vegas_line),
        vegas_over_under: action_game.vegas_over_under,
        home_team_final_score: (action_game.home_team_final_score || massey_game.home_team_final_score),
        away_team_final_score: (action_game.away_team_final_score || massey_game.away_team_final_score),
        home_team_spread_percent: action_game.home_team_ats_percent,
        away_team_spread_percent: action_game.away_team_ats_percent,
        over_percent: action_game.over_percent,
        under_percent: action_game.under_percent,
        game_over: action_game.game_over || Date.today > (massey_game.game_date + 1.day),
        home_team_money_percent: action_game.home_team_ml_percent,
        away_team_money_percent: action_game.away_team_ml_percent,
        home_contrarian:        action_game.home_contrarian,
        away_contrarian:        action_game.away_contrarian,
        home_rlm:               action_game.home_rlm,
        away_rlm:               action_game.away_rlm,
        away_steam:             action_game.away_steam,
        home_steam:             action_game.home_steam,
        home_overall_rating:    action_game.home_overall_rating,
        away_overall_rating:    action_game.away_overall_rating,
        home_team_logo:         action_game.home_team_logo,
        away_team_logo:         action_game.away_team_logo,
        home_team_abbr:         action_game.home_team_abbr,
        away_team_abbr:         action_game.away_team_abbr,
      }
    game_hash = merge_pred_game_stats(game_hash, pred_game) if pred_game
    game_hash = merge_massey_game_stats(game_hash, massey_game) if massey_game

    saved = game.update(game_hash)
    puts "Unable to save game #{game.home_team_name} vs #{game.away_team_name}" unless saved
  end

  def merge_massey_game_stats(game_hash, massey_game)
    massey_game_hash =
      {
        home_team_massey_line: massey_game.home_team_massey_line,
        away_team_massey_line: massey_game.away_team_massey_line,
        massey_over_under: massey_game.massey_over_under,
      }
    game_hash.merge(massey_game_hash)
  end

  def merge_pred_game_stats(game_hash, pred_game)
    pred_game_hash =
      {
        average_home_predicted_line: pred_game.average_home_predicted_line,
        median_home_predicted_line: pred_game.median_home_predicted_line,
        standard_deviation_of_pred: pred_game.standard_deviation_of_pred,
        probability_home_wins: pred_game.probability_home_wins,
        probability_home_covers: pred_game.probability_home_covers
      }
    game_hash.merge(pred_game_hash)
  end
end
