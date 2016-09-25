class GameController < ApplicationController
  def index
    @ncaa_line_games = Game.where('line_diff > ?', 5).order('line_diff DESC').where(sport: 'ncaa_football')
    @ncaa_over_under_games = Game.where('over_under_diff > ?', 5).order('over_under_diff DESC').where(sport: 'ncaa_football')
    @nfl_line_games = Game.where('line_diff > ?', 3).order('line_diff DESC').where(sport: 'nfl_football')
    @nfl_over_under_games = Game.where('over_under_diff > ?', 3).order('over_under_diff DESC').where(sport: 'nfl_football')

  end

  def show
  end
end
