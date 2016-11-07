class Games::Fetch < Less::Interaction
  expects :url
  expects :sport
  expects :date

  def run
    fetch
  end

  private

  def fetch
    Games::FetchMasseyData.run(massey_url: url, sport: sport)
    Games::FetchPublicPercentage.run(date: date, sport: sport)
    Games::GameOver.run
    Games::FetchFinalScore.run(massey_url: url, sport: sport)
		Games::CalculateAll.run()
  end
end
