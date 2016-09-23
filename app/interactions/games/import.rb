class Games::Import < Less::Interaction
  expects :url
  expects :sport
  #  http://www.masseyratings.com/pred.php?s=cf&sub=11604
  # Games::Import.run(url: 'http://www.masseyratings.com/pred.php?s=cf&sub=11604', sport: 'ncaa_football' )

  def run
    html = get_massey_html
    fetch_and_save_team_data(html)
  end

  private

  def save_game(game_hash)
    unless Game.where(home_team_name: game_hash[:home_team_name], away_team_name: game_hash["away_team_name"]).present?
      Game.create!(game_hash)
    end
  end

  def get_massey_html
    browser = Watir::Browser.new :phantomjs
    browser.goto url
    browser.button(id: 'showVegas').click
    doc = Nokogiri::HTML(browser.html)
    browser.close
    doc.css('.bodyrow')
  end

  def fetch_and_save_team_data(html)
    html.each do |row|
      unless invalid_data(row)
        game_hash = set_game_hash(row)

        save_game(game_hash)
      end
    end
  end

  def invalid_data(row)
    if    row.css('.fscore')[1].children.first.text == "---"
      true
    elsif row.css('.fscore')[1].children.last.text == "---"
      true
    elsif row.css('.fscore').last.children.first.text == "---"
      true
    else
      false
    end
  end

  def set_game_hash(row)
    {
      home_team_massey_line:  get_home_team_massey_line(row),
      away_team_massey_line:  -get_home_team_massey_line(row),
      away_team_name:         row.css('.fteam').first.css('a').first.children.text,
      home_team_name:         row.css('.fteam').first.css('a').last.children.text,
      home_team_vegas_line:   get_home_team_vegas_line(row),
      away_team_vegas_line:   -get_home_team_vegas_line(row),
      vegas_over_under:       row.css('.fscore').last.children.first.text.to_f,
      massey_over_under:      row.css('.fscore').last.children.last.text.to_f,
      date:                   format_date(row),
      sport:                  sport,
      line_diff:              (get_home_team_massey_line(row) - get_home_team_vegas_line(row)).abs,
      over_under_diff:        (row.css('.fscore').last.children.first.text.to_f - row.css('.fscore').last.children.last.text.to_f).abs,
      team_to_bet:            find_team_to_bet(row),
      over_under_pick:        pick_over_under(row)
    }
  end

  def pick_over_under(row)
    if row.css('.fscore').last.children.last.text.to_f - row.css('.fscore').last.children.first.text.to_f > 0
      "Over"
    else
      "Under"
    end
  end

  def find_team_to_bet(row)
    if get_home_team_massey_line(row) - get_home_team_vegas_line(row) > 0
      row.css('.fteam').first.css('a').first.children.text
    else
      row.css('.fteam').first.css('a').last.children.text
    end
  end

  def format_date(row)
    Date.parse(row.css('.fdate').first.children.first.children.first.text)
  end

  def get_home_team_massey_line(row)
    game_array = row.css('.fscore')[1].children.to_a
    return -1 * game_array.first.text.to_f if game_array.first.attributes["class"].value == 'ltgreen'
    return game_array.last.text.to_f if game_array.last.attributes["class"].value == ' ltgreen'
  end

  def get_home_team_vegas_line(row)
    game_array = row.css('.fscore')[1].children.to_a
    return -1 * game_array.first.text.to_f if game_array.first.attributes["class"].value == 'ltred'
    return game_array.last.text.to_f if game_array.last.attributes["class"].value == 'ltred'
  end

  def game_params(game_data)
    {
      sport: sport,
      home_team_name: game_data[:home_team_ame],
      away_team_name: game_data[:away_team_name],
      home_team_massey_line: game_data[:homw_team_massey_line],
      away_team_massey_line: game_data[:away_team_massey_line],
      home_team_vegas_line: game_data[:home_team_vegas_line],
      away_team_vegas_line: game_data[:away_team_vegas_line],
      vegas_over_under: game_data[:vegas_over_under],
      massey_over_under: game_data[:massey_over_under],
      line_diff: (game_data[:home_team_massey_line] - game_data[:home_team_vegas_line]).abs,
      date: game_data[:date]
    }
  end
end
