WunderGame.all.each do |game|
  game.update(processed: false)
end

MasseyGame.all.each do |game|
  game.update(processed: false)
end

 Games::FetchPastGameData.run(sport: "nfl", start_date: "2016/10/20", end_date: "2016/10/24")

 Games::ProcessGames.run
