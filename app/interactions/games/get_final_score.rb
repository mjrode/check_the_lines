class Games::GetFinalScore < Less::Interaction
  expects :massey_url
  expects :sport

  def run
    html = get_massey_html
    fetch_and_save_team_data(html)
  end

  def get_massey_html
    browser = Watir::Browser.new :phantomjs
    browser.goto massey_url
    browser.button(id: 'showVegas').click
    doc = Nokogiri::HTML(browser.html)
    browser.close
    doc
  end

  def fetch_and_save_team_data(html)
    @week_id = html.css('#datepicker').first.attributes['value'].value
    rows = html.css('.bodyrow')
    rows.each do |row|
      create_instance_variables(row)
      update_score
    end
  end

  def update_score
    game = Game.find_by_away_team_name(@away_team_name)
    game.update(
      away_team_final_score: @away_team_final_score,
      home_team_final_score: @home_team_final_score
    ) unless game.nil?
  end

  def create_instance_variables(row)
    @away_team_final_score =  row.css('.fscore').first.children.first.text.to_i
    @home_team_final_score =  row.css('.fscore').first.children.last.children.text.to_i
    @away_team_name        =  row.css('.fteam').first.css('a').first.children.text
  end


end
