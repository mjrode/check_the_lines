class Games::LoadAllData < Less::Interaction
  def run
    load
  end

  private

  def load
    import_massey_data
    import_public_percentage
    Games::Fetch.run
  end

  def import_massey_data
    urls.each do |url|
      Games::ImportMasseyData.run(url: url, sport: "ncaa_football")
    end
  end

  def import_public_percentage
    dates.each do |date|
      Games::GetPublicPercentage.run(date: date)
    end
  end

  def urls
    [
      "http://www.masseyratings.com/cf/11604/games?dt=20160927",
      "http://www.masseyratings.com/cf/11604/games?dt=20161004",
      "http://www.masseyratings.com/cf/11604/games?dt=20161011",
      "http://www.masseyratings.com/cf/11604/games?dt=20161018"
    ]
  end

  def dates
    ["1", "8", "15", "22"]
  end
end
