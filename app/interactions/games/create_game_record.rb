class Games::CreateGameRecord < Less::Interaction

  def run
    process_massey_and_wunder_data
  end

  private

  def process_massey_and_wunder_data
    # Changing from unprocessed to game_over that way the %'s update throughout the day as the jobs run

    MasseyGame.where("(game_over = false) or processed = false").each do |massey_game|
      next if massey_game.game_date < Date.today && massey_game.processed == true
      home_team_name = format_name(massey_game.home_team_name, massey_game.sport)
      away_team_name = format_name(massey_game.away_team_name, massey_game.sport)
      wunder_game = WunderGame.where("sport = ?", massey_game.sport).where(game_date: (massey_game.game_date - 5.days)..(massey_game.game_date + 5.days) )
      .where('home_team_name ILIKE ? OR away_team_name ILIKE ?', "%#{home_team_name}%", "%#{away_team_name}%").first
      puts "Could not find a match for massey game #{massey_game.away_team_name} vs #{massey_game.home_team_name}" if wunder_game.nil?
      next if wunder_game.nil?
      game = find_or_create_game(massey_game, wunder_game)
      save_or_update_game(game, massey_game, wunder_game)
      mark_massey_and_wunder_processed(wunder_game, massey_game) if wunder_game.game_over
    end
  end
  
  def format_name(name, sport)
    case sport
    when 'cf'
      Conversions::MapNcaafTeam.run(team_name: name)
    when 'nfl'
      Conversions::MapNflTeam.run(team_name: name)
    else
      name
    end
  end

  def find_or_create_game(massey_game, wunder_game)
    Game.find_or_initialize_by(
      sport: massey_game.sport,
      date: massey_game.game_date,
      home_team_name: wunder_game.home_team_name
    )
  end

  def mark_massey_and_wunder_processed(wunder_game, massey_game)
    wunder_game.update(processed: true)
    massey_game.update(processed: true)
  end

  def save_or_update_game(game, massey_game, wunder_game)
    game_hash =
    {
      sport: massey_game.sport,
      date: massey_game.game_date,
      time: massey_game.time,
      home_team_name: wunder_game.home_team_name,
      away_team_name: wunder_game.away_team_name,
      home_team_massey_line: massey_game.home_team_massey_line,
      away_team_massey_line: massey_game.away_team_massey_line,
      home_team_vegas_line: (wunder_game.home_team_vegas_line || massey_game.home_team_vegas_line),
      away_team_vegas_line:   (wunder_game.away_team_vegas_line || massey_game.away_team_vegas_line),
      vegas_over_under: wunder_game.vegas_over_under,
      home_team_final_score: (wunder_game.home_team_final_score || massey_game.home_team_final_score),
      away_team_final_score: (wunder_game.away_team_final_score || massey_game.away_team_final_score),
      home_team_spread_percent: wunder_game.home_team_ats_percent,
      away_team_spread_percent: wunder_game.away_team_ats_percent,
      massey_over_under: massey_game.massey_over_under,
      over_percent: wunder_game.over_percent,
      under_percent: wunder_game.under_percent,
      game_over: massey_game.game_over || Date.today > (massey_game.game_date),
      home_team_money_percent: wunder_game.home_team_ml_percent,
      away_team_money_percent: wunder_game.away_team_ml_percent,
      home_contrarian:        wunder_game.home_contrarian,
      away_contrarian:        wunder_game.away_contrarian,
      home_rlm:               wunder_game.home_rlm,
      away_rlm:               wunder_game.away_rlm,
      away_steam:             wunder_game.away_steam,
      home_steam:             wunder_game.home_steam,
      home_overall_rating:    wunder_game.home_overall_rating,
      away_overall_rating:    wunder_game.away_overall_rating
    }
    game.update(game_hash)
  end
end
