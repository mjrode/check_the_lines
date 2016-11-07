class Games::FetchUrls < Less::Interaction
  def run
    urls
  end

  private

  def week_ids
    Game.where(game_over: [false, nil]).pluck(:week_id, :sport).uniq
  end

  def urls
		url = []
    week_ids.each do |week_id|
      ncaa_football_url(week_id, url) if week_id.last == "ncaa_football"
      nfl_url(week_id, url) if week_id.last == "nfl"
			nba_url(week_id, url) if week_id.last == "nba"
    end
		url
  end

  def ncaa_football_url(week_id, url)
		url << {"ncaa_football": "http://www.masseyratings.com/cf/11604/games?dt=#{week_id.first}"}
  end

  def nfl_url(week_id, url)
		url << {"nfl": "http://www.masseyratings.com/nfl/games?dt=#{week_id.first}"}
  end
	
	def nba_url(week_id, url)
		url << {"nba": "http://www.masseyratings.com/nba/games?dt=#{week_id.first}"}
	end
end
