class AdminController < ApplicationController
  def refresh
    fetch_and_update_game_data
    redirect_to root_path
  end

  private

  def fetch_and_update_game_data
    puts "Fetching game data after controller action #{action_name}"
    Jobs::FetchAndProcessCurrentData.run(process_all_games: true)
    Jobs::ProcessAndUpdateGames.run(process_all_games: true)
  end
end
