class Jobs::ProcessAndUpdateGames < Less::Interaction
  expects :process_all_games, allow_nil: true

  def run
    process
  end

  def process
    # puts "Process all games is set to #{process_all_games}" if process_all_games
    Games::CreateGameRecord.run(process_all_games: process_all_games)
    Games::CalculateAll.run(process_all_games: process_all_games)
    puts RESULTS

    # all_correct_bets =  Game.all_correct_picks.count.to_f
    # all_bets = Game.game_over.count
    # all_win_percent =  (all_correct_bets / all_bets).round(2)
    # puts "Win percentage #{all_win_percent}% Correct All Bets #{all_bets} Total Bet Count #{all_correct_bets}\n\n"


    # all_correct_bets =  Game.low_public_percentage_and_correct.count.to_f
    # all_bets = Game.low_public_percentage.count
    # all_win_percent =  (all_correct_bets / all_bets).round(2)
    # puts "Win percentage #{all_win_percent}% Correct Public All Bets #{all_correct_bets} Total Public Bet Count #{all_bets}\n\n"

    win_percent =  (Game.all_correct_spread_best_bets.count.to_f/ Game.all_best_bets.count.to_f).round(2)
    best_bet_count = Game.all_best_bets.count.to_f
    correct_best_bet_count = Game.all_correct_spread_best_bets.count.to_f
    puts "\n\nWin percentage #{win_percent}% Correct Best Bets #{correct_best_bet_count} Total Best Bet Count #{best_bet_count}\n\n"

  end
end
