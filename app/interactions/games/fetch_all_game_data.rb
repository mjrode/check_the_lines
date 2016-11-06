class Games::FetchAllGameData < Less::Interaction
	expects :url
	expects :date
	expects :sport
	expects :next_month, allow_nil: true

	def run
    Games::ImportMasseyData.run(url: url, sport: sport)
    Games::GetPublicPercentage.run(date: date, sport: sport, next_month: next_month)
    Games::GameOver.run
    Games::GetFinalScore.run(massey_url: url, sport: sport)
		Games::CalculateAll.run()
	end

	private
end
