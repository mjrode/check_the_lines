class Games::GameOver < Less::Interaction

  def run
    urls.each do |url|
      html = get_massey_html(url)
      fetch_and_save_team_data(html)
    end
  end

  private

  def urls
    week_ids.map {|id| "http://www.masseyratings.com/cf/11604/games?dt=#{id}"}
  end

  def week_ids
    Game.where(game_over: false).pluck(:week_id).uniq
  end

  def get_massey_html(url)
    browser = Watir::Browser.new :phantomjs
    browser.goto url
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
        update_game if game_over(row)
    end
  end

  def update_game
    game = Game.where(away_team_name: @away_team_name, home_team_name: @home_team_name).first
    game.update(
      game_over: true
    ) unless game.nil?
  end

  def game_over(row)
    return true if row.css('.fdate .detail').text == "FINAL"
    false
  end

  def create_instance_variables(row)
    @away_team_name        =  row.css('.fteam').first.css('a').first.children.text
    @home_team_name        =  row.css('.fteam').first.css('a').last.children.text
  end


end
