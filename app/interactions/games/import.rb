class Games::Import < Less::Interaction
  expects :url
  expects :sport
  expects :date

  def run
    fetch
  end

  private

  def fetch
    Games::ImportMasseyData.run(massey_url: url, sport: sport)
    Games::GetPublicPercentage.run(date: date, sport: sport)
    Games::GameOver.run
    Games::GetFinalScore.run(massey_url: url, sport: sport)
		Games::CalculateAll.run()
  end
end
