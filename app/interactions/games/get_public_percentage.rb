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
    game = Game.where(away_team_name: @away_team_name, home_team_name: @home_team_name).first
    game.update(
      away_team_final_score: @away_team_final_score,
      home_team_final_score: @home_team_final_score
    ) unless game.nil?
  end

  def create_instance_variables(row)
    parse_json(row)
    @home_team_name           = "@ #{@team_array[5]}"
    @away_team_name           = @team_array[3]
    @home_team_money_percent  = @team_array[10]
    @away_team_money_percent  = @team_array[7]
    @home_team_spread_percent = @team_array[19]
    @away_team_spread_percent = @team_array[16]
    @over_percent             = @team_array[22]
    @under_percent            = @team_array[25]
  end

  def parse_json(row)
    @team_array = row.css('.hidden-xs.col-sm-1').first.children[1].attributes.first[1].value.gsub('viewMatchup','').gsub('(', '[').gsub(')',']').split(',')
  end


end
