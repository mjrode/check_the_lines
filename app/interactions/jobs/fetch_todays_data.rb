class Jobs::FetchTodaysData < Less::Interaction
  expects :date, allow_nil: true

  def run
		run_and_import_data
  end

  private

  def run_and_import_data
    date = Date.today.strftime("%F").gsub("-","/")
    puts "Sports #{SPORTS}"
    SPORTS.each do |sport|
      puts "running: Fetch::Massey.run(sport: '#{sport}', date: '#{date}')"
			Fetch::Massey.run(sport: sport, date: date)
      puts "running: Fetch::Action.run(sport: '#{sport}', date: '#{date}')"
			Fetch::Action.run(sport: sport)
		end
  end
end
