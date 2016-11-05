class Games::FetchUrls < Less::Interaction
  def run
    urls
  end

  private

  def week_ids
    Game.where(game_over: [false, nil]).pluck(:week_id, :sport).uniq
  end

  def urls
    week_ids.map do |week_id|
      ncaa_football_url(week_id) if week_id.last == "ncaa_football"
      nfl_url(week_id) if week_id.last == "nfl"
    end
  end

  def ncaa_football_url(week_id)
    "http://www.masseyratings.com/cf/11604/games?dt=#{week_id.first}"
  end

  def nfl_url(week_id)
    "http://www.masseyratings.com/nfl/games?dt=#{week_id.first}"
  end
end
