class GamesController < ApplicationController
  before_action :set_filter_params

  def home
    @sport_filter = 'all'
    select_games_for_display
  end

  def nfl
    @sport_filter = 'nfl'
    select_games_for_display
  end

  def ncaaf
    @sport_filter = 'ncaaf'
    select_games_for_display
  end

  def best_bets
    @game_filter = :best_bets
    select_games_for_display
  end

  private

  def select_games_for_display
    @games = Game.all.order('date ASC').order('time ASC')
    @game_filter ||= 'not_over'
    puts "Game filter ------------- #{@game_filter}"
    puts "Sport filter ------------- #{@sport_filter}"
    @games = @games.send(@game_filter) if @game_filter
    @games = @games.where(sport: @sport_filter) if @sport_filter && @sport_filter != 'all'
    @games = @games.reorder('date DESC').order('time ASC') if @game_filter == 'game_over'
  end

  def set_filter_params
    @game_filter = params['game_filter']
    @sport_filter = params['sport_filter']
  end
end
