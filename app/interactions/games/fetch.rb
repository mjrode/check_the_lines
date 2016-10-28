class Games::Fetch < Less::Interaction
  expects :sport, allow_nil: true
  expects :date, allow_nil: true
  expects :url, allow_nil: true

  def run
    fetch
  end

  private

  def set_url
    url || 'http://www.masseyratings.com/cf/11604/games?dt=20161017'
  end

  def set_sport
    sport || 'ncaa_football'
  end

  def fetch
    Games::ImportMasseyData.run(massey_url: set_url, sport: set_sport)
    Games::GetPublicPercentage.run(date: date)
    Games::GameOver.run
    Games::GetFinalScore.run(massey_url: set_url, sport: set_sport)
    Game.all.each do |game|
      Games::Calculate.run(game: game)
    end
  end
end
