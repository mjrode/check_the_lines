class Games::FetchPastGameData < Less::Interaction
  expects :sport
  expects :days_back, allow_nil: true
  expects :start_date, allow_nil: true
  expects :end_date, allow_nil: true

  def run
    fetch_data
  end

  private

  def fetch_data
    if sport == "all"
      SPORTS.each do |a_sport|
        date_range.each do |date|
          Games::FetchMasseyData.run(sport: a_sport, date: date)
          Games::FetchWunderData.run(sport: a_sport, date: date)
        end
      end
    else
      date_range.each do |date|
        Games::FetchMasseyData.run(sport: sport, date: date)
        Games::FetchWunderData.run(sport: sport, date: date)
      end
    end
  end

  def date_range
    return ((Date.today - days_back.days)..Date.today).map{ |date| date.strftime("%F").gsub("-","/") } if days_back.present?
    (Date.parse(start_date)..Date.parse(end_date)).map{ |date| date.strftime("%F").gsub("-","/") }
  end
end
