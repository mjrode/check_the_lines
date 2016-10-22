class Games::GetPublicPercentage < Less::Interaction

  def run
    html = get_public_html
    fetch_and_save_team_data(html)
  end

  def get_public_html
    browser = Watir::Browser.new :phantomjs
    browser.goto "https://www.sportsbook.ag/trends/ncaaf"
    doc = Nokogiri::HTML(browser.html)
    browser.close
    doc
  end

  def fetch_and_save_team_data(html)
    rows = html.css('.bt-odd', '.bt-even')
    rows.each do |row|
      create_instance_variables(row)
      update_score
    end
  end

  def update_score
    game = Game.where('away_team_name=? OR home_team_name=?', "#{@away_team_name}", "#{@home_team_name}").last
    @public_percent_on_massey_team = game.get_public_percent_on_massey_team unless game.nil?
    game.update(
      home_team_money_percent: @home_team_money_percent,
      away_team_money_percent: @away_team_money_percent,
      home_team_spread_percent: @home_team_spread_percent,
      away_team_spread_percent: @away_team_spread_percent,
      over_percent: @over_percent,
      under_percent: @under_percent,
      public_percentage_on_massey_team: @public_percent_on_massey_team
    ) unless game.nil?
  end

  def create_instance_variables(row)
    parse_json(row)
    @home_team_name           = "@ #{@team_array[5]}".gsub("'","")
    @away_team_name           = @team_array[3].gsub("'","")
    @home_team_money_percent  = @team_array[10].delete! "''%"
    @away_team_money_percent  = @team_array[7].delete! "''%"
    @home_team_spread_percent = @team_array[19].delete! "''%"
    @away_team_spread_percent = @team_array[16].delete! "''%"
    @over_percent             = @team_array[22].delete! "''%"
    @under_percent            = @team_array[25].delete! "''%"

  end

  def parse_json(row)
    @team_array = row.css('.hidden-xs.col-sm-1').first.children[1].attributes.first[1].value.gsub('viewMatchup','').gsub('(', '[').gsub(')',']').split(',')
  end
end
