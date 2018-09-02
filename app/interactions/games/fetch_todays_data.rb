class Games::FetchTodaysData < Less::Interaction

  def run
		run_and_import_data
  end

  private

  def run_and_import_data
		date = Date.today.strftime("%F").gsub("-","/")
		SPORTS.each do |sport|
			Games::FetchMasseyData.run(sport: sport, date: date)
			Games::FetchActionData.run(sport: sport, date: date)
		end
  end
end
