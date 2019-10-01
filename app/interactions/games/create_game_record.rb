class Games::CreateGameRecord < Less::Interaction
  expects :process_all_games, allow_nil: true

  def run
    process_massey_and_action_data
  end

  private

  def process_massey_and_action_data
    # Changing from unprocessed to game_over that way the %'s update throughout the day as the jobs run

    games_to_process =
      if process_all_games
        MasseyGame.all
      else
        MasseyGame.where("(game_over = false) or processed = false")
      end

    games_to_process.each do |massey_game|
      home_team_name = massey_game.home_team_name
      away_team_name = massey_game.away_team_name

      action_game = ActionGame.where("sport = ?", massey_game.sport).where(game_date: (massey_game.game_date - 5.days)..(massey_game.game_date + 5.days) ).where(home_team_name: home_team_name, away_team_name: away_team_name).first

      puts "Could not find a match for massey game #{massey_game.away_team_name} vs #{massey_game.home_team_name}" if action_game.nil?
      next if action_game.nil?
      game = find_or_create_game(massey_game, action_game)
      save_or_update_game(game, massey_game, action_game)
      mark_massey_and_action_processed(action_game, massey_game) if action_game.game_over
    end
  end

  def find_or_create_game(massey_game, action_game)
    Game.find_or_initialize_by(
      sport: massey_game.sport,
      date: massey_game.game_date,
      external_id: action_game.external_id,
      home_team_name: action_game.home_team_name,
      away_team_name: action_game.away_team_name,
    )
  end

  def mark_massey_and_action_processed(action_game, massey_game)
    action_game.update(processed: true)
    massey_game.update(processed: true)
  end

  def set_game_time(massey_game)
    massey_game.game_over ? 'Final' : massey_game.time
  end

  def save_or_update_game(game, massey_game, action_game)
    game_hash =
    {
      external_id: action_game.external_id,
      sport: massey_game.sport,
      date: massey_game.game_date,
      time: set_game_time(massey_game),
      home_team_name: action_game.home_team_name,
      away_team_name: action_game.away_team_name,
      home_team_massey_line: massey_game.home_team_massey_line,
      away_team_massey_line: massey_game.away_team_massey_line,
      home_team_vegas_line: (action_game.home_team_vegas_line || massey_game.home_team_vegas_line),
      away_team_vegas_line:   (action_game.away_team_vegas_line || massey_game.away_team_vegas_line),
      vegas_over_under: action_game.vegas_over_under,
      home_team_final_score: (action_game.home_team_final_score || massey_game.home_team_final_score),
      away_team_final_score: (action_game.away_team_final_score || massey_game.away_team_final_score),
      home_team_spread_percent: action_game.home_team_ats_percent,
      away_team_spread_percent: action_game.away_team_ats_percent,
      massey_over_under: massey_game.massey_over_under,
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
      away_team_abbr:         action_game.away_team_abbr
    }
    game.update(game_hash)
  end
end
