class Games::FetchTodaysData < Less::Interaction

  def run
		run_and_import_data
  end

  private

  def run_and_import_data
		date = Date.today.strftime("%F").gsub("-","/")
		SPORTS.each do |sport|
			Fetch::Massey.run(sport: sport, date: date)
			Fetch::Action.run(sport: sport, date: date)
		end
  end
end
