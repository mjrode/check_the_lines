class FetchGameData

  def initialize(url: 'http://www.masseyratings.com/cf/11604/games?dt=20161017', sport: 'ncaa_football', date: nil)
    @url = url
    @sport = sport
  end

  def fetch
    Games::ImportMasseyData.run(massey_url: @url, sport: @sport)
    Games::GetPublicPercentage.run(date: @date)
    Games::GameOver.run
    Games::GetFinalScore.run(massey_url: @url, sport: @sport)
    Game.calculate_picks
    Game.was_i_right?
  end
end
