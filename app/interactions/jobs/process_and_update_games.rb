class Jobs::ProcessAndUpdateGames < Less::Interaction
  expects :process_all_games, allow_nil: true

  def run
    process
  end

  def process
    puts "Process all games is set to #{process_all_games}"
    Games::CreateGameRecord.run(process_all_games: process_all_games)
    Games::CalculateAll.run(process_all_games: process_all_games)
  end
end
