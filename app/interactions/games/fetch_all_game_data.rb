class Games::FetchAllGameData < Less::Interaction
	expects :url
	expects :date, allow_nil: true
	expects :sport
	expects :sportsbook_month, allow_nil: true

	def run
    Games::FetchMasseyData.run(url: url, sport: sport, sportsbook_month: sportsbook_month)
    Games::FetchPublicPercentage.run(date: date, sport: sport, sportsbook_month: sportsbook_month)
	end

  def months_back
	 	Date.today.strftime("%m").to_i - url.last(8)[4..5].to_i
  end
end
