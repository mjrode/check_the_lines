class GamesController < ApplicationController
  def index
  end

  def show
  end

  def unplayed
    @games = Game.all.unplayed.valid_spread
  end

  def played
    @games = Game.all.played.valid_spread
  end

  def best_bets
    @new_games = Game.all.unplayed.valid_spread.spread_best_bets
  end

  def old_best_bets
    @old_games = Game.all.played.valid_spread.spread_best_bets
  end

  def old_over_under_best_bets
    @old_games = Game.all.played.valid_over_under.over_under_best_bets
  end

  def refresh
    FetchGameData.new.fetch
    redirect_to best_bets_games_path
  end
end
