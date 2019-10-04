class Jobs::ProcessCurrentData < Less::Interaction
  expects :process_all_games, allow_nil: true
  expects :do_not_fetch_data, allow_nil: true
  def run
    Jobs::FetchTodaysData.run unless do_not_fetch_data
    Jobs::ProcessAndUpdateGames.run(process_all_games: process_all_games)
  end

end
