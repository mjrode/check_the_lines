class CheckIfOver
  attr_reader :game, :date

  def initialize(game)
    @game = game
    @date = game.date
  end

  def game_over?
    if Date.today > @date
      @game.game_over = true
      @game.save
    else
      @game.game_over = false
      @game.save
    end
  end

end
