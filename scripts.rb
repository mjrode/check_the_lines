WunderGame.all.each do |game|
  game.update(processed: false)
end

MasseyGame.all.each do |game|
  game.update(processed: false)
end



 Games::FetchPastGameData.run(sport: "all", start_date: "2016/12/10", end_date: "2017/07/01")

 Games::FetchPastGameData.run(sport: "mlb", start_date: "2017/07/17", end_date: "2017/07/24")

 Games::ProcessGames.run

Games::FetchTodaysData.run

 # No Wunder Data for 2016/12/27, cb: Error: undefined method `css' for nil:NilClass

# Total games correct count
correct = Game.where(best_bet: true, correct_over_under_prediction: true).count + Game.where(best_bet: true, correct_prediction: true).count

# Total games incorrect count
incorrect = Game.where(best_bet: true, correct_over_under_prediction: false).count + Game.where(best_bet: true, correct_prediction: false).count

# Percentage correct
correct / (correct + incorrect)
