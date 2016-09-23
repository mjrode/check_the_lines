class Games::Import < Less::Interaction
  expects :url
  expects :sport
#  http://www.masseyratings.com/pred.php?s=cf&sub=11604

  def run
    data = []
    html = get_massey_html
    fetch_and_save_team_data(html, data)
  end

  private

  def save_game(game_data)
    unless Game.where(home_team_name: game_data[:team_name_1], away_team_name: game_data["team_name_2"]).present?
      Game.create!(save_params(game_data))
    end
  end


  def get_massey_html
    browser = Watir::Browser.new
    browser.goto url
    browser.button(id: 'showVegas').click
    doc = Nokogiri::HTML(browser.html)
    browser.close
    doc.css('.bodyrow')
  end

  def fetch_and_save_team_data(html, data)
    html.each do |row|
      unless invalid_data(row)

        game_data = {
          home_team_massey_line:  get_home_team_massey_line(row),
          away_team_massey_line:  -get_home_team_massey_line(row),
          home_team_name:         row.css('.fteam').first.css('a').first.children.text,
          away_team_name:         row.css('.fteam').first.css('a').last.children.text,
          home_team_vegas_line:   get_home_team_vegas_line(row),
          away_team_vegas_line:   -get_home_team_vegas_line(row),
          vegas_over_under:       row.css('.fscore').last.children.first.text.to_f,
          massey_over_under:      row.css('.fscore').last.children.last.text.to_f,
          date:                   format_date(row)
        }

        save_game(game_data)

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
      home_team_name: game_data[:team_name_1],
      away_team_name: game_data[:team_name_2],
      home_team_massey_line: game_data[:team_1_massey_line],
      away_team_massey_line: game_data[:team_2_massey_line],
      home_team_vegas_line: game_data[:team_1_vegas_line],
      away_team_vegas_line: game_data[:team_2_vegas_line],
      vegas_over_under: game_data[:vegas_over_under],
      massey_over_under: game_data[:massey_over_under],
      line_diff: (game_data[:team_1_massey_line] - game_data[:team_1_vegas_line]).abs,
      date: game_data[:date]
   }
  end

      # if team_1_line >= 0

      #   if team_2_line == "---" || team_1_line == "---"
      #     team_1_massey_line = 0
      #     team_2_massey_line = 0
      #   end

      #   if massey_over_under == "---"
      #     vegas_over_under = 0
      #     massey_over_under = 0
      #   end


      #   if team_1_line.between?(vegas_line - 0.1, vegas_line +  0.1)
      #     team_1_vegas_line = vegas_line
      #     team_2_vegas_line = vegas_line * -1
      #   else
      #     team_1_vegas_line = vegas_line * -1
      #     team_2_vegas_line = vegas_line
      #   end

      #   if team_1_line.between?(massey_line - 0.1, massey_line + 0.1)
      #     team_1_massey_line = massey_line
      #     team_2_massey_line = -massey_line
      #   else
      #     team_1_massey_line = -massey_line
      #     team_2_massey_line = massey_line
      #   end
      # else

      #   if team_1_line.between?(vegas_line + 0.1, vegas_line -  0.1)
      #     team_1_vegas_line = vegas_line
      #     team_2_vegas_line = vegas_line * -1
      #   else
      #     team_2_vegas_line = vegas_line
      #     team_1_vegas_line = vegas_line * -1
      #   end

      #   if team_1_line.between?(massey_line + 0.1, massey_line - 0.1)
      #       team_1_massey_line = massey_line
      #       team_2_massey_line = -massey_line
      #   else
      #       team_1_massey_line = -massey_line
      #       team_2_massey_line = massey_line
      #   end

    #   game_data = {
    #     team_name_1: team_name_1,
    #     team_name_2: team_name_2,
    #     team_1_vegas_line: team_1_vegas_line,
    #     team_2_vegas_line: team_2_vegas_line,
    #     team_1_massey_line: team_1_massey_line,
    #     team_2_massey_line: team_2_massey_line,
    #     vegas_over_under: vegas_over_under,
    #     massey_over_under: massey_over_under
    #     # date: Date.parse(date)
    #   }
    #   save_game(game_data)
    # end
  # end



end
