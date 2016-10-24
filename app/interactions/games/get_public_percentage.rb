class Games::GetPublicPercentage < Less::Interaction

  def run
    html = get_public_html
    fetch_and_save_team_data(html)
  end

  def get_public_html
    browser = Watir::Browser.new :phantomjs
    browser.goto "http://pregame.com/sportsbook_spy/default.aspx"
    browser.link(:text =>"CFB").when_present.click
    doc = Nokogiri::HTML(browser.html)
    browser.close
    doc
  end

  def fetch_and_save_team_data(html)
    rows = html.css('#tblSpy').children
    rows.each do |row|
      create_instance_variables(row) if valid_row(row)
      update_score
    end
  end

  def valid_row(row)
    return false if row.children.blank?
    return false if row.children[1].children[7].blank? && row.children[3].children[5].blank?
    true
  end

  def update_score
    game = Game.where('away_team_name=? OR home_team_name=?', "#{@away_team_name}", "@ #{@home_team_name}").where('date >= ?', Date.today).last
    puts "Updating #{@away_team_name}, #{@home_team_name}"
    # @public_percent_on_massey_team = game.get_public_percent_on_massey_team unless game.nil?
    game.update(
      home_team_spread_percent: @home_team_spread_percent,
      away_team_spread_percent: @away_team_spread_percent,
      over_percent: @over_percent,
      under_percent: @under_percent,
      public_percentage_on_massey_team: @public_percent_on_massey_team,
      home_team_vegas_line: @home_spread,
      away_team_vegas_line: @away_spread,
      vegas_over_under: @vegas_over_under
    ) unless game.nil?
  end

  def create_instance_variables(row)
    @home_team_name           = row.children[3].children[5].text.strip
    @home_spread              = row.children[3].children[9].text.strip.gsub(/\(.*?\)/, '')
    @vegas_over_under         = row.children[3].children[13].text.strip.gsub(/\(.*?\)/, '').gsub('u','').strip
    @away_team_name           = row.children[1].children[7].text.strip
    @away_spread              = row.children[1].children[11].text.strip.gsub(/\(.*?\)/, '')
    @away_team_spread_percent = row.children[1].children[19].text.strip
    @home_team_spread_percent = row.children[3].children[15].text.strip
    @under_percent            = row.children[3].children[19].text.strip
    @over_percent             = row.children[1].children[23].text.strip
  end
end
