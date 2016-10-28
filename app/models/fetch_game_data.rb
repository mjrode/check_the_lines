class FetchGameData

  def initialize(url = 'http://www.masseyratings.com/cf/11604/games?dt=20161017', date = nil, sport = 'ncaa_football')
    @url = url
    @sport = sport
  end

  def fetch
    Games::ImportMasseyData.run(date: @date, sport: @sport)
    binding.pry
    Games::GetPublicPercentage.run(date: @date)
    Games::GameOver.run
    Games::GetFinalScore.run(massey_url: @url, sport: @sport)
    Game.all.each do |game|
      Games::Calculate.run(game: game)
    end
  end
end
