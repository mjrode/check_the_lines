class GamesController < ApplicationController
  before_action :set_filter_params, :select_games_for_display

  def home
    puts "Params -- #{params}"
  end

  private

  def select_games_for_display
    @games = Game.all.order('date ASC')
    return @games = @games.not_over unless @sport_filter || @game_filter
    @games = @games.send(@game_filter) if @game_filter
    @games = @games.where(sport: @sport_filter) if @sport_filter && @sport_filter != 'all'

    @games.order('date DESC')
  end

  def set_filter_params
    @game_filter = params['game_filter']
    @sport_filter = params['sport_filter']
  end
end
