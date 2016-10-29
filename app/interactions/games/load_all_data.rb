class Games::LoadAllData < Less::Interaction
  def run
    load
  end

  private

  def load
    date_url.each do |date, url|
      Games::Fetch.run(date: date, url: url, sport: "ncaa_football")
    end
  end

  def dates
    dates = ["1", "8", "15", "22"]
  end

  def date_url
    {
      "1"  => "http://www.masseyratings.com/cf/11604/games?dt=20160927",
      "8"  =>  "http://www.masseyratings.com/cf/11604/games?dt=20161004",
      "15" => "http://www.masseyratings.com/cf/11604/games?dt=20161011",
      "22" => "http://www.masseyratings.com/cf/11604/games?dt=20161018"
    }
  end
end
