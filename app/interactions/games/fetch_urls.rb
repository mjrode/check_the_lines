class Games::FetchUrls < Less::Interaction
	expects :function

  def run
    urls
  end

  private

  def week_ids
    return Game.where(game_over: [false, nil]).pluck(:week_id, :sport).uniq if function == "game_over"
    return Game.where(home_team_final_score: [0, nil]).pluck(:week_id, :sport).uniq if function == "final_score"
  end

  def urls
		url = []
    week_ids.each do |week_id|
      ncaa_football_url(week_id, url) if week_id.last == "ncaa_football"
      nfl_url(week_id, url) if week_id.last == "nfl"
			nba_url(week_id, url) if week_id.last == "nba"
			ncaa_basketball_url(week_id, url) if week_id.last == "ncaa_basketball"
    end
		url
  end

  def ncaa_basketball_url(week_id, url)
		url << {"ncaa_basketball": "http://www.masseyratings.com/cb/11590/games?dt=#{week_id.first}"}
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
