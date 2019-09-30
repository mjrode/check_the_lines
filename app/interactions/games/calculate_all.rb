class Games::CalculateAll < Less::Interaction
    expects :process_all_games, allow_nil: true

  def run
    calculate_all
  end

  def calculate_all
    games =
      if process_all_games
        Game.all
      else
        Game.where("(game_over = false) or processed = false")
      end

    games.each do |game|
      next if game.processed == true && !process_all_games
      Games::Calculate.run(game: game)
    end
  end
end
