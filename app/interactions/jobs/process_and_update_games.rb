class Jobs::ProcessAndUpdateGames < Less::Interaction
  expects :process_all_games, allow_nil: true

  def run
    process
  end

  def process
    Games::CreateGameRecord.run(process_all_games: process_all_games)
    Games::CalculateAll.run(process_all_games: process_all_games)
    puts RESULTS
  end
end
