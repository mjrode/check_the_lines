class GameController < ApplicationController
  def index
    @current_games = Game.where("date > ?", Date.today)
    @ncaa_line_games = Game.where('line_diff > ?', 5).order('line_diff DESC').where(sport: 'ncaa_football')
    @ncaa_over_under_games = Game.where('over_under_diff > ?', 5).order('over_under_diff DESC').where(sport: 'ncaa_football')
    @nfl_line_games = Game.where('line_diff > ?', 3).order('line_diff DESC').where(sport: 'nfl_football')
    @nfl_over_under_games = Game.where('over_under_diff > ?', 3).order('over_under_diff DESC').where(sport: 'nfl_football')
  end

  def show
  end

  def unplayed
    @ncaa_line_games = Game.where('date >= ?', Date.today).order('line_diff DESC').where(sport: 'ncaa_football').where.not(home_team_vegas_line: -0.0).where.not(home_team_vegas_line: 0.0)
  end
end
