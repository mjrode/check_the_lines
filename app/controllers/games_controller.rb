class GamesController < ApplicationController
  def index
  end

  def show
    # @games = Game.where(week_id: params(week_id))
  end

  def unplayed
    @games = Game.all.unplayed.spread_valid_public
  end

  def played
    @games = Game.all.played.spread_valid_public
  end

  def best_bets
    @new_games = Game.all.spread_best_bets.spread_valid_public.where(game_over: false)
  end

  def old_best_bets
    @old_games = Game.all.spread_best_bets.spread_valid_public.where(game_over: true)
  end

  def old_over_under_best_bets
    @old_games = Game.all.over_under_best_bets.over_under_valid_public.where(game_over: true)
  end
end
