class Games::FetchFinalScore < Less::Interaction
  expects :game

  def run
    game_hash = create_game_hash
    fetch_game_data(game_hash)

  end

  private

  def create_game_hash
    games = {}
    Game.not_over.each do |game|
      games[game.date] = game.sport
    end
    games
  end

  def fetch_game_data(game_hash)
    game_hash.each do |date, sport|
      Games::FetchMasseyData.run(sport: sport, date: date)
      Games::FetchWunderData.run(sport: sport, date: date)
    end
  end
end
