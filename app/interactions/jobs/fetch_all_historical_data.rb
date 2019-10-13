class Jobs::FetchAllHistoricalData < Less::Interaction
  expects :future, allow_nil: true

  def run
    run_and_import_data
    calculate_and_update_data
  end

  private

  def run_and_import_data
    SPORTS.each do |sport|
      res = Fetch::Action.run(sport: sport, get_league_info: true)
      fetch_historical_action_data(res, sport)
      fetch_historical_massey_data(res, sport)
    end
  end

  def calculate_and_update_data
    Jobs::ProcessAndUpdateGames.run(process_all_games: true)
  end

private
  def fetch_historical_massey_data(res, sport)
    array_of_start_date_of_weeks(res).each do |date|
      puts "Fetching historical data for Massey, sport: #{sport}, date: #{date}"
      Fetch::Massey.run(sport: sport, date: Date.parse(date))
    end
  end

  def fetch_historical_action_data(res, sport)
    array_of_past_weeks(res).each do |week|
      puts "Getting historical action data for #{sport} week #{week}"
      Fetch::Action.run(sport: sport, week: week)
    end
  end

  def array_of_past_weeks(res)
    current_week = res['current_week']
    return [ "#{current_week + 1}" ] if future
    res['calendar_info']['reg'].map{|week| week['week']}.select{|week| week <= current_week}
  end

  def array_of_start_date_of_weeks(res)
    current_week = res['current_week']
    week_index = res['current_week'] - 1
    return Array.wrap(res['calendar_info']['reg'][current_week + 1]['startDate']) if future
    res['calendar_info']['reg'][0..week_index].map{|week| week['startDate']}
  end
end
