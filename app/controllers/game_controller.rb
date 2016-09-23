class GameController < ApplicationController
  def index
    @games = Game.where('line_diff > ?', 5)


  end

  def show
  end
end
