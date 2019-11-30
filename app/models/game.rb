class Game < ActiveRecord::Base
  validates :external_id, uniqueness: true

  scope :game_over, -> { where(game_over: true) }
  scope :not_over, -> { where(game_over: false) }
  scope :played, -> { where('date < ?', Date.today) }

  scope :correct_picks,
        -> { where(correct_prediction: true, game_over: true) }
  scope :correct_spread_best_bets,
        -> { where(best_bet: true, correct_prediction: true, game_over: true) }
  scope :best_bets_game_over,
        -> { where(best_bet: true, game_over: true).where_not(correct_prediction: nil) }
  scope :best_bets, -> { where(best_bet: true).reorder('date DESC') }
end
