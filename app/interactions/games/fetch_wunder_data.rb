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
      game = WunderGame.find_or_create_by(external_id: @external_id)
      WunderGame.update(game.id, game_hash)
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
# class Games::FetchPublicPercentage < Less::Interaction
#   expects :date, allow_nil: true
#   expects :sport, allow_nil: true
#   expects :sportsbook_month, allow_nil: true
#
#   def run
#     html = Games::FetchHtml.run(url: public_betting_url, date: date, sport: sport, sportsbook_month: sportsbook_month)
#     fetch_and_save_team_data(html)
#   end
#
#   def public_betting_url
#     "http://pregame.com/sportsbook_spy/default.aspx"
#   end
#
#   def fetch_and_save_team_data(html)
#     rows = html.css('#tblSpy').children
#     rows.each do |row|
#       create_instance_variables(row) if valid_row(row)
#       update_score if valid_row(row)
#     end
#   end
#
#   def valid_row(row)
#     return false if row.css('.block td:nth-child(5)').text.strip.blank?
#     true
#   end
#
#   def update_score
#     game = Game.where(sport: sport).where('away_team_name=? OR home_team_name=?', "#{@away_team_name}", "#{@home_team_name}").where(date: formatted_date-5..formatted_date+2).last
#     game.update(game_hash) unless game.nil?
#   end
#
#   def formatted_date
#     year  = @remote_date.last(2)
#     month = @remote_date.first(2)
#     day   = @remote_date[3..4]
#     Date.parse("#{year}/#{month}/#{day}")
#   end
#
#   def create_instance_variables(row)
#     @remote_date              = row.css('td:nth-child(1)').first.text.strip
#     @away_team_name           = row.css('td:nth-child(4)').first.children.text.strip
#     @home_spread              = row.css('.block td:nth-child(5)').text.strip.to_i
#     @vegas_over_under         = row.css('.block td:nth-child(7)').text.gsub(/\(.*?\)/, '').gsub('u','').strip.to_i
#     @home_team_name           = row.css('.block strong').text.strip
#     @away_spread              = -@home_spread
#     @away_team_spread_percent = row.css('.perc:nth-child(10) .sblock').text.to_i
#     @home_team_spread_percent = 100 - @away_team_spread_percent
#     @over_percent             = row.css('.perc:nth-child(12)').text.to_i
#     @under_percent            = 100 - @over_percent
# 		@time                    = row.css('td:nth-child(1)').last.text.strip
#   end
#
#   def game_hash
#     {
#       home_team_spread_percent: @home_team_spread_percent,
#       away_team_spread_percent: @away_team_spread_percent,
#       over_percent: @over_percent,
#       under_percent: @under_percent,
#       home_team_vegas_line: @home_spread,
#       away_team_vegas_line: @away_spread,
#       vegas_over_under: @vegas_over_under,
# 			time: @time
#     }
#   end
#
# 	def set_nba_name
# 		@away_team_name = Games::MapNbaGame.run(team_name: @away_team_name)
# 		@home_team_name = Games::MapNbaGame.run(team_name: @home_team_name)
# 	end
#
# end
