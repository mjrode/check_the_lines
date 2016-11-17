class Games::FetchTodaysData < Less::Interaction
  def run
    load
  end

  private

  def load
    Games::GameOver.run
    Games::FetchFinalScore.run()
		Games::CalculateAll.run()
		Games::FetchAllGameData.run(url: "http://www.masseyratings.com/pred.php?s=nba", sport: "nba")
		Games::FetchAllGameData.run(url: "http://www.masseyratings.com/pred.php?s=nfl", sport: "nfl")
		Games::FetchAllGameData.run(url: "http://www.masseyratings.com/pred.php?s=cf&sub=11604", sport: "ncaa_football")
		Games::FetchAllGameData.run(url: "http://www.masseyratings.com/pred.php?s=cb&sub=11590", sport: "ncaa_basketball")
  end

end
