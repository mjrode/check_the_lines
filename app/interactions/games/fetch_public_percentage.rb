class Games::FetchPublicPercentage < Less::Interaction
  expects :date, allow_nil: true
  expects :sport, allow_nil: true
	expects :last_month, allow_nil: true

  def run
    html = Games::FetchHtml.run(url: public_betting_url, date: date, sport: sport, last_month: last_month)
    fetch_and_save_team_data(html)
		Games::CalculateAll.run
  end

	def public_betting_url
    "http://pregame.com/sportsbook_spy/default.aspx"
	end

  def fetch_and_save_team_data(html)
    rows = html.css('#tblSpy').children
    rows.each do |row|
      create_instance_variables(row) if valid_row(row)
      update_score if valid_row(row)
    end
  end

  def valid_row(row)
    return false if row.css('.block td:nth-child(5)').text.strip.blank?
    true
  end

  def update_score
    game = Game.where(sport: sport).where('away_team_name=? OR home_team_name=?', "#{@away_team_name}", "#{@home_team_name}").where(date: formatted_date-5..formatted_date+2).first
    game.update(game_hash) unless game.nil?
  end

  def formatted_date
    year  = @remote_date.last(2)
    month = @remote_date.first(2)
    day   = @remote_date[3..4]
    Date.parse("#{year}/#{month}/#{day}")
  end

  def create_instance_variables(row)
    @remote_date              = row.css('td:nth-child(1)').first.text.strip
    @away_team_name           = row.css('td:nth-child(4)').first.children.text.strip
    @home_spread              = row.css('.block td:nth-child(5)').text.strip.to_i
    @vegas_over_under         = row.css('.block td:nth-child(7)').text.gsub(/\(.*?\)/, '').gsub('u','').strip.to_i
    @home_team_name           = row.css('.block strong').text.strip
    @away_spread              = -@home_spread
    @away_team_spread_percent = row.css('.perc:nth-child(10) .sblock').text.to_i
    @home_team_spread_percent = 100 - @away_team_spread_percent
    @under_percent             = row.css('.perc:nth-child(12)').text.to_i
    @over_percent            = 100 - @under_percent
  end

  def game_hash
    {
      home_team_spread_percent: @home_team_spread_percent,
      away_team_spread_percent: @away_team_spread_percent,
      over_percent: @over_percent,
      under_percent: @under_percent,
      public_percentage_on_massey_team: @public_percent_on_massey_team,
      home_team_vegas_line: @home_spread,
      away_team_vegas_line: @away_spread,
      vegas_over_under: @vegas_over_under
    }
  end
end
