module SportsHelper
  def table_header_text(sport_filter, game_filter)
   "#{format_sport_title(sport_filter)} #{format_game_title(game_filter)}"
  end

  private

  def format_sport_title(sport)
    title_map = {'ncaaf': 'NCAAF', 'nfl': 'NFL'}
    title_map[sport&.to_sym] || 'All'
  end

  def format_game_title(sport)
    title_map = {'not_over': 'Live and Upcoming Games', 'game_over': 'Historical Games', 'all_best_bets': 'Historical Best Bets' }
    title_map[sport&.to_sym] || 'Live'
  end
end
