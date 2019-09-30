class Jobs::FetchAllHistoricalData < Less::Interaction

  def run
		run_and_import_data
  end

  private

  def run_and_import_data
		date = Date.today.strftime("%F").gsub("-","/")

    SPORTS.each do |sport|
      res = Fetch::Action.run(sport: sport, get_league_info: true)
        fetch_historical_action_data(res, sport)
        fetch_historical_massey_data(res, sport)
      end
  end

private

  def fetch_historical_massey_data(res, sport)
    array_of_start_date_of_weeks(res).each do |date|
      Fetch::Massey.run(sport: sport, date: Date.parse(date))
    end
  end

  def fetch_historical_action_data(res, sport)
    array_of_past_weeks(res).each do |week|
      puts "Getting historical data for #{sport} week #{week}"
      Fetch::Action.run(sport: sport, week: week)
    end
  end

  def array_of_past_weeks(res)
    current_week = res['current_week']
    calendar_info = res['calendar_info']['reg']
    res['calendar_info']['reg'].map{|week| week['week']}.select{|week| week <= current_week}
  end

  def array_of_start_date_of_weeks(res)
    week_index = res['current_week'] - 1
    res['calendar_info']['reg'][0..week_index].map{|week| week['startDate']}
  end

end
