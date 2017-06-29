class Games::FetchWunderData < Less::Interaction
  expects :sport
  expects :date

  # https://www.wunderdog.com/public-consensus/nba.html?date=04%2F11%2F2017
  # Games::FetchWunderData.run(sport: "nba", date: "2017/04/11")
  def run
    html = Games::FetchHtml.run(url: url)
    games = parse_html(html)
    save_wunder_data(games)
  end

  private

  def url
    "https://www.wunderdog.com/public-consensus/#{sport}.html?date=#{format_date}"
  end

  def save_wunder_data(games)
    games.drop(3).each_slice(2) do |game|
      create_instance_variables(game)
      fetch_spread_data(game)
      game = WunderGame.find_or_initialize_by(external_id: @external_id)
      game.update(game_hash)
    end
  end

  def fetch_spread_data(game)
    id = game[1].children.children[1].attributes["id"].text
    url = "https://www.wunderdog.com/consensus/viewScoreOdds/event_id/#{id}.html?width=610"
    spread_data = Games::FetchHtml.run(url: url)
    game = spread_data.xpath("//table")[2]

    @away_team_vegas_line = game.children[1].children[2].children[3].text.strip.split(" ").first.to_f
    @home_team_vegas_line = @away_team_vegas_line * -1
    @vegas_over_under     = game.children[1].children[4].children[3].text.strip.split(" ").first.gsub("O","").to_f
    @external_id                   = id.to_i
  end

  def create_instance_variables(game)
    @away_team_name        = game[0].children[5].text
    @away_team_ats_percent = game[0].children[9].text.strip.gsub("%","")
    @away_team_ml_percent  = game[0].children[15].text.strip.gsub("%","")
    @over_percent          = game[0].children[21].text.strip.gsub("%","")
    @home_team_name        = game[1].children[5].text
    @home_team_ats_percent = game[1].children[9].text.strip.gsub("%","")
    @home_team_ml_percent  = game[1].children[15].text.strip.gsub("%","")
    @under_percent         = game[1].children[21].text.strip.gsub("%","")
    @game_time             = game[0].children[1].text.strip
  end

  def game_hash
    {
      away_team_name:         @away_team_name,
      away_team_ats_percent:  @away_team_ats_percent,
      away_team_ml_percent:   @away_team_ml_percent,
      over_percent:           @over_percent,
      home_team_name:         @home_team_name,
      home_team_ats_percent:  @home_team_ats_percent,
      home_team_ml_percent:   @home_team_ml_percent,
      under_percent:          @under_percent,
      home_team_vegas_line:   @home_team_vegas_line,
      away_team_vegas_line:   @away_team_vegas_line,
      vegas_over_under:       @vegas_over_under,
      sport:                  sport,
      # Need to get date from HTML
      # game[1].children[1].children[1].attributes["name"].value.split("-").last.split(",").first
      # returns: " Tuesday April 11"
      # could use that and the year passed in
      game_time:              Time.parse(@game_time),
      date:                   Date.parse(date),
      external_id:            @external_id
    }
  end

  def parse_html(html)
    html.xpath("//table")[3].css("tbody").first.css("tr")
  end

  def format_date
    split_date = date.split("/")
    split_date[1] + "%2F" + split_date[2] + "%2F" + split_date[0]
  end
end
