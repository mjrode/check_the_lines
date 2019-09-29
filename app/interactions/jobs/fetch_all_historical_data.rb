class Jobs::FetchAllHistoricalData < Less::Interaction

  def run
		run_and_import_data
  end

  private

  def run_and_import_data
		date = Date.today.strftime("%F").gsub("-","/")
    SPORTS.each do |sport|
      res = Fetch::Action.run(sport: sport, get_league_info: true)
      array_of_past_weeks(res).each do |week|
        puts "Getting historical data for #{sport} week #{week}"
        Fetch::Action.run(sport: sport, week: week)
      end
		end
  end

private

  def array_of_past_weeks(res)
    current_week = res['current_week']
    calendar_info = res['calendar_info']['reg']
    res['calendar_info']['reg'].map{|week| week['week']}.select{|week| week <= current_week}
  end

end
