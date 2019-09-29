class Games::CalculateAll < Less::Interaction
  def run
    calculate_all
  end

  def calculate_all
    Game.where("(game_over = false) or processed = false").each do |game|
      next if game.processed == true
      Games::Calculate.run(game: game)
    end
  end
end
