class GameController < ApplicationController
  def index
    @line_games = Game.where('line_diff > ?', 5).order('line_diff DESC')
    @over_under_games = Game.where('over_under_diff > ?', 5).order('over_under_diff DESC')

  end

  def show
  end
end
