class FetchGameData

  def initialize(url: 'http://www.masseyratings.com/pred.php?s=cf&sub=11604', sport: 'ncaa_football')
    @url = url
    @sport = sport
  end

  def fetch
    Games::ImportMasseyData.run(massey_url: @url, sport: @sport)
    Games::GetPublicPercentage.run()
    Games::GameOver.run
    Game.calculate_picks
    Game.was_i_right?
  end
end
