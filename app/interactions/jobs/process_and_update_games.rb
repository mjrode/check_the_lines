class Jobs::ProcessAndUpdateGames < Less::Interaction
  expects :process_all_games, allow_nil: true

  def run
    process
  end

  def process
    Games::CreateGameRecord.run(process_all_games: process_all_games)
    Games::CalculateAll.run(process_all_games: process_all_games)
    puts RESULTS

    win_percent =
      (Game.correct_spread_best_bets.count / Game.best_bets.count.to_f).round(2)
    best_bet_count = Game.best_bets.count.to_f
    correct_best_bet_count = Game.correct_spread_best_bets.count.to_f
    puts "\n\nWin percentage #{win_percent}% Correct Best Bets #{
           correct_best_bet_count
         } Total Best Bet Count #{best_bet_count}\n\n"
  end
end
