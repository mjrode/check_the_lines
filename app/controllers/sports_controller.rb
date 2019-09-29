class SportsController < ApplicationController
  # before_action :fetch_and_update_game_data
  def ncaaf
    @game_filter = params['game_filter']
    puts params['game_filter']
    games = Game.where(sport: 'cf')
    @games = if @game_filter
      games.send(@game_filter)
    else
      games = Game.where(sport: 'cf', game_over: false)
    end
  end

  def refresh
    fetch_and_update_game_data
    redirect_to action: 'ncaaf'
  end

  private

  def fetch_and_update_game_data
    puts "Fetching game data after controller action #{action_name}"
    # Jobs::ProcessCurrentData.run(process_all_games: true)
    Jobs::ProcessAndUpdateGames.run(process_all_games: true)
  end
end
