class SportsController < ApplicationController
  def ncaaf
    @unplayed_ncaaf_games = Game.where(sport: 'cf', game_over: false)
    #code
  end
end
