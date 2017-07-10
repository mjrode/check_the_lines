class Games::FetchWunderData < Less::Interaction
  expects :sport
  expects :date

  # https://www.wunderdog.com/public-consensus/nba.html?date=04%2F11%2F2017
  # Games::FetchWunderData.run(sport: "nba", date: "2017/04/11")
  def run
    puts url
    html = Games::FetchHtml.run(url: url)
    games = parse_html(html)
    return "No data for #{date} #{sport}" if games.nil?
    save_wunder_data(games)
  end

  private

  def url
    "https://www.wunderdog.com/public-consensus/#{sport_code}.html?date=#{format_date}"
  end

  def save_wunder_data(games)
    games.drop(3).each_slice(2) do |game|
      create_instance_variables(game)
      return if @away_team_name.downcase == "moneyline"
      fetch_spread_data(game)
      game = WunderGame.find_or_initialize_by(external_id: @external_id)
      game.update(game_hash)
    end
  end

  def sport_code
    case sport
    when 'cb'
      'cbb'
    else
      sport
    end
  end

  def fetch_spread_data(game)
    begin
      id = game[1].children.children[1].attributes["id"].text
      url = "https://www.wunderdog.com/consensus/viewScoreOdds/event_id/#{id}.html?width=610"
      spread_data = Games::FetchHtml.run(url: url)
      game = spread_data.xpath("//table")[2]
      if game.nil?
        game = spread_data.xpath("//table")[1]
        @home_team_vegas_line = game.children[1].children[2].children[5].text.strip.split(" ").first.to_f
        @away_team_vegas_line = game.children[1].children[2].children[3].text.strip.split(" ").first.to_f
        @vegas_over_under     = game.children[1].children[4].children[3].text.strip.split(" ").first.gsub("O","").to_f
        @away_team_money_line = game.children[1].children[6].children[3].children[1].text.to_f
        @home_team_money_line = game.children[1].children[6].children[5].children[1].text.to_f
      else
        @away_team_vegas_line  = game.children[1].children[2].children[3].text.strip.split(" ").first.to_f
        @home_team_vegas_line  = @away_team_vegas_line * -1
        @vegas_over_under      = game.children[1].children[4].children[3].text.strip.split(" ").first.gsub("O","").to_f
        @game_over             = game_over?(spread_data)
        if @game_over
          @home_team_final_score = spread_data.xpath("//table")[1].css("tr")[2].children[-2].text.strip.to_i
          @away_team_final_score = spread_data.xpath("//table")[1].css("tr")[1].children[-4].text.strip.to_i
        else
          @home_team_final_score = 0
          @away_team_final_score = 0
        end

      end
      @external_id = id.to_i
    rescue NoMethodError => e
      puts "ERROR: #{sport}::#{date} - Missing #{e}"
    end
  end

  def create_instance_variables(game)
    @away_team_name        = game[0].children[5].text
    return if @away_team_name.downcase == "moneyline"
    @away_team_ats_percent = game[0].children[9].text.strip.gsub("%","")
    @away_team_ml_percent  = game[0].children[15].text.strip.gsub("%","")
    @over_percent          = game[0].children[21].text.strip.gsub("%","")
    @home_team_name        = game[1].children[5].text
    @home_team_ats_percent = game[1].children[9].text.strip.gsub("%","")
    @home_team_ml_percent  = game[1].children[15].text.strip.gsub("%","")
    @under_percent         = game[1].children[21].text.strip.gsub("%","")
    @game_time             = game[0].children[1].text.strip
    @game_date             = wunder_date(game)
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
      game_time:              Time.parse(@game_time),
      game_date:              @game_date,
      external_id:            @external_id,
      away_team_final_score:  @away_team_final_score,
      game_over:              @game_over,
      home_team_final_score:  @home_team_final_score
    }
  end

  def parse_html(html)
    begin
      return html.xpath("//table")[3].css("tbody").first.css("tr") if multiple_games?(html)
      html.xpath("//table").first.css("tbody").first.css("tr")
    rescue NoMethodError => e
      puts "No Wunder Data for #{date}, #{sport}: Error: #{e}"
    end
  end

  def wunder_date(game)
    Date.parse(game[1].css("a")[1]["name"].split("-").last)
  end

  def game_over?(spread_data)
    final = spread_data.xpath("//table")[1].css("tr")[1].css("td").last.children.first.text.downcase
    final == "final" ? true : false
  end

  def format_date
    split_date = date.split("/")
    split_date[1] + "%2F" + split_date[2] + "%2F" + split_date[0]
  end

  def multiple_games?(html)
    html.xpath("//table")[3] ? true : false
  end
end
