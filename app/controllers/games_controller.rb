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
    @games = Game.all.best_bets
  end
end
