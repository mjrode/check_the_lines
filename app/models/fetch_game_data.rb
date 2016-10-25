class FetchGameData

  def initialize(url: 'http://www.masseyratings.com/pred.php?s=cf&sub=11604', sport: 'ncaa_football')
    @url = url
    @sport = sport
  end

  def fetch
    Games::ImportMasseyData.run(massey_url: @url, sport: @sport)
    Games::GetPublicPercentage.run()
    Game.calculate_picks
  end
end
