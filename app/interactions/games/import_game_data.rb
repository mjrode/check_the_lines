class Games::ImportGameData < Less::Interaction

  def run
  end

  private

  def find_unprocessed_games
    MasseyGame.unprocessed
  end

end
