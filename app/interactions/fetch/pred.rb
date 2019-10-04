class Fetch::Pred < Less::Interaction
  expects :sport

  def run
    url = construct_url
    html = Common::FetchHtml.run(url: url)
    pred_array = parse_html(html)
    save_games(pred_array)
  end

  private

  def construct_url
    puts "Fetching pred data for #{sport}"
    url = "http://www.thepredictiontracker.com/pred#{sport_code}.html"
    puts "URL for request #{url}"
    url
  end

  def sport_code
    case sport
    when 'ncaaf'
      'ncaa'
    else
      sport
    end
  end

  def parse_html(html)
    csv_table = html.xpath('//pre').first.text.split("\n")
    index = csv_table.find_index {|row| row.include?('Deviation')} + 1
    games = csv_table.drop(index).reject(&:blank?).reject{|row| row.include?('____________________')}
    create_pred_array(games)
  end

  def create_pred_array(games)
    games.map do |game|
      name_game_array = game.split(/[ \t]{2,}/)
      game_array = game.split(' ')[-10..-1]
      {
        external_id: "#{Date.today}-#{format_name(name_game_array[0]).gsub(/\s++/, '').downcase}-#{format_name(name_game_array[1]).gsub(/\s++/, '').downcase}",
        home_team: format_name(name_game_array[0]),
        away_team: format_name(name_game_array[1]),
        average_home_predicted_line: game_array[3],
        median_home_predicted_line: game_array[4],
        standard_deviation_of_pred: game_array[5],
        probability_home_wins: game_array[8],
        probability_home_covers: game_array[9],
        sport: sport,
        date: Date.today
      }
    end
  end

  def format_name(name)
    if sport == 'ncaaf'
      Conversions::MapNcaafPredTeam.run(team_name: name)
    elsif sport == 'nfl'
      Conversions::MapNflPredTeam.run(team_name: name)
    else
      name
    end
  end

  def save_games(games)
    games.each do |game_hash|
      game = ::PredGame.where(external_id: game_hash[:external_id]).first_or_create
      game.update(game_hash)
    end
  end
end