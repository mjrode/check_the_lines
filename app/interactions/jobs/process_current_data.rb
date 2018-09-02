class Jobs::ProcessCurrentData < Less::Interaction

  def run
    Games::FetchTodaysData.run  
    Games::ProcessGames.run
  end

end
