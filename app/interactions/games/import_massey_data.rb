class Games::ImportMasseyData < Less::Interaction
  expects :url
  expects :sport

  def run
    html = Games::FetchHtml.run(url: url, sport: sport)
    fetch_and_save_team_data(html)
  end

  private

  def fetch_and_save_team_data(html)
    set_week_id(html)
    rows = html.css('.bodyrow')
    rows.each do |row|
      create_instance_variables(row)
      save_game(game_hash)
    end
  end

  def save_game(game_hash)
      game = Game.find_or_create_by(
        home_team_name: @home_team_name,
        away_team_name: @away_team_name
      )
      Game.update(game.id, game_hash)
  end

  def set_week_id(html)
    @week_id = html.css('#datepicker').first.attributes['value'].value
  end

  def game_hash
    {
      home_team_massey_line:  @home_team_massey_line,
      away_team_massey_line:  @away_team_massey_line,
      away_team_name:         @away_team_name,
      home_team_name:         @home_team_name,
      massey_over_under:      @massey_over_under,
      date:                   @date,
      sport:                  @sport,
      week_id:                @week_id
    }
  end

  def format_date(row)
    date = row.css('.fdate').first.children.first.children.first.text
    date = date[-2 .. -1]
    Date.parse(date)
  end

  def get_home_team_massey_line(row)
    game_array = row.css('.fscore')[1].children.to_a
    return -1 * game_array.first.text.to_f if game_array.first.attributes["class"].value == 'ltgreen'
    return game_array.last.text.to_f if game_array.last.attributes["class"].value == ' ltgreen'
  end

  def create_instance_variables(row)
    @home_team_massey_line =  get_home_team_massey_line(row)
    @away_team_massey_line =  -get_home_team_massey_line(row)
    @away_team_name        =  NameFormatter.new(row.css('.fteam').first.css('a').first.children.text).format_name
    @home_team_name        =  NameFormatter.new(row.css('.fteam').first.css('a').last.children.text).format_name
    @massey_over_under     =  row.css('.fscore').last.children.first.text.to_f
    @date                  =  format_date(row)
    @sport                 =  sport
  end
end
