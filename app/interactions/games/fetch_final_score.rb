class Games::FetchFinalScore < Less::Interaction
  expects :url
  expects :sport

  def run
    html = Games::FetchHtml.run(url: url, sport: sport)
    fetch_and_save_team_data(html)
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
    game = Game.where(away_team_name: @away_team_name, home_team_name: @home_team_name).last
    game.update(
      away_team_final_score: @away_team_final_score,
      home_team_final_score: @home_team_final_score
    ) unless game.nil?
  end

  def create_instance_variables(row)
    @away_team_final_score =  row.css('.fscore').first.children.first.text.to_i
    @home_team_final_score =  row.css('.fscore').first.children.last.children.text.to_i
    @away_team_name        =  NameFormatter.new(row.css('.fteam').first.css('a').first.children.text).format_name
    @home_team_name        =  NameFormatter.new(row.css('.fteam').first.css('a').last.children.text).format_name
  end


end
