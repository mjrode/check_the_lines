class Games::GetPublicPercentage < Less::Interaction
  expects :date, allow_nil: true

  def run
    html = get_public_html
    fetch_and_save_team_data(html)
  end

  def get_public_html
    browser = Watir::Browser.new :phantomjs
    browser.goto "http://pregame.com/sportsbook_spy/default.aspx"
    browser.link(:text =>"CFB").when_present.click
    change_date(browser) unless date.nil?
    doc = Nokogiri::HTML(browser.html)
    browser.close
    doc
  end

  def change_date(browser)
    browser.link(:text =>"Change Date").when_present.click
    browser.link(:text =>date).when_present.click
  end

  def fetch_and_save_team_data(html)
    rows = html.css('#tblSpy').children
    rows.each do |row|
      create_instance_variables(row) if valid_row(row)
      update_score if valid_row(row)
      binding.pry if @away_team_name == "@ Toledo"
    end
  end

  def valid_row(row)
    return false if row.children.blank?
    return false if row.children[1].children[7].blank? && row.children[3].children[5].blank?
    true
  end

  def update_score
    puts "Updating #{@away_team_name}, #{@home_team_name}"
    game = Game.where('away_team_name=? OR home_team_name=?', "#{@away_team_name}", "@ #{@home_team_name}").where(date: formatted_date).first
    game.update(game_hash) unless game.nil?
  rescue NoMethodError
    puts "Unable to Read Row #{@away_team_name}"
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

  rescue NoMethodError
    puts "Error getting data for #{@home_team_name} vs #{@away_team_name}"
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
