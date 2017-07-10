WunderGame.all.each do |game|
  game.update(processed: false)
end

MasseyGame.all.each do |game|
  game.update(processed: false)
end

 Games::FetchPastGameData.run(sport: "nfl", start_date: "2016/10/20", end_date: "2016/10/24")

 Games::FetchPastGameData.run(sport: "all", start_date: "2016/10/20", end_date: "2017/07/01")

 Games::FetchPastGameData.run(sport: "cf", start_date: "2017/08/30", end_date: "2017/07/01")

 Games::ProcessGames.run

 # No Wunder Data for 2016/12/27, cb: Error: undefined method `css' for nil:NilClass
