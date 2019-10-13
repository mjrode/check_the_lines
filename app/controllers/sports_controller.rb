class SportsController < ApplicationController
  before_action :set_filter_params, :select_games_for_display

  def ncaaf
    puts "Params -- #{params}"
  end

  def best_bets
  end

  def refresh
    fetch_and_update_game_data
    redirect_to action: 'best_bets'
  end

  private

  def fetch_and_update_game_data
    puts "Fetching game data after controller action #{action_name}"
    Jobs::ProcessCurrentData.run(process_all_games: true)
    Jobs::ProcessAndUpdateGames.run(process_all_games: true)
  end

  def select_games_for_display
    puts "Selecting games for display"
    @games = Game.all
    return @games = @games.not_over unless @sport_filter || @game_filter
    @games = @games.send(@game_filter) if @game_filter
    @games = @games.where(sport: format_sport_for_search(@sport_filter)) if @sport_filter && @sport_filter != 'all'
    @games.order('date ASC')
  end

  def format_sport_for_search(sport)
    sport_search_map = {'ncaaf': 'ncaaf'}
    sport_search_map[sport.to_sym] || sport
  end

  def set_filter_params
    @game_filter = params['game_filter']
    @sport_filter = params['sport_filter']
  end
end
