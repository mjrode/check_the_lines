class Jobs::ProcessCurrentData < Less::Interaction
  expects :process_all_games, allow_nil: true
  def run
    Jobs::FetchTodaysData.run
    Jobs::ProcessAndUpdateGames.run(process_all_games: process_all_games)
  end

end
