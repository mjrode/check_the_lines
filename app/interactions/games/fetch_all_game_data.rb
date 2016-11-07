class Games::FetchAllGameData < Less::Interaction
	expects :url
	expects :date, allow_nil: true
	expects :sport
	expects :last_month, allow_nil: true

	def run
    Games::FetchMasseyData.run(url: url, sport: sport)
    Games::FetchPublicPercentage.run(date: date, sport: sport, last_month: last_month)
    Games::GameOver.run
    Games::FetchFinalScore.run(massey_url: url, sport: sport)
		Games::CalculateAll.run()
	end

	private
end
