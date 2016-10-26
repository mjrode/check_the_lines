class GamesController < ApplicationController
  def index
  end

  def show
    # @games = Game.where(week_id: params(week_id))
  end

  def unplayed
    @games = Game.all.unplayed
  end

  def played
    @games = Game.all.played
  end

  def best_bets
    @new_games = Game.all.best_bets.valid_public.where(game_over: false)
  end

  def old_best_bets
    @old_games = Game.all.best_bets.valid_public.where(game_over: true)
  end
end
