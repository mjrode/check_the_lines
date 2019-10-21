module SportsHelper
  def table_header_text(sport_filter, game_filter)
    format_game_title(sport_filter, game_filter)
  end

  def format_date_time(game)
    "#{game.date.strftime("%m/%d/%Y")} @ #{game.time}"
  end

  private

  def format_sport_title(sport)
    title_map = {'ncaaf': 'NCAAF', 'nfl': 'NFL'}
    title_map[sport&.to_sym] || ''
  end

  def format_game_title(sport, game)
    title_map = {'not_over': "Current #{format_sport_title(sport)} Games", 'game_over': "Historical #{format_sport_title(sport)} Games", 'best_bets': 'Historical Best Bets' }
    title_map[game&.to_sym] || 'Live'
  end
end
