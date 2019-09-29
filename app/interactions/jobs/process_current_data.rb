class Jobs::ProcessCurrentData < Less::Interaction

  def run
    Jobs::FetchTodaysData.run
    Jobs::ProcessAndUpdateGames.run
  end

end
