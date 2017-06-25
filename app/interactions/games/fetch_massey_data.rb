class Games::FetchMasseyData < Less::Interaction
  expects :sport
	expects :date

  def run
    url = construct_url
    games = Common::FetchJSON.run(url: url)["DI"]
    fetch_and_save_massey_data(games)
  end

  private

  def construct_url
    "http://www.masseyratings.com/predjson.php?s=#{sport_code}&dt=#{format_date}"
  end

  def sport_code
    case sport
    when 'mlb'
      'mlb&sub=14342'
    when 'cf'
      'cf&sub=11604'
    else
      sport
    end
  end

  def fetch_and_save_massey_data(games)
    games.each do |game|
      game = convert_to_hash(game)
      create_instance_variables(game)
      save_game(game_hash)
    end
  end

  def convert_to_hash(game)
    hash = Hash[game.map.with_index.to_a]
    Hash[hash.to_a.collect(&:reverse)]
  end

  def save_game(game_hash)
    return "Missing Massey data" if (game_hash[:home_team_massey_line] == 0.0 || game_hash[:home_team_massey_line] == -0.0)
    game = Game.find_or_create_by(
      home_team_name: @home_team_name,
      away_team_name: @away_team_name
    )
    Game.update(game.id, game_hash)
  end

  def game_hash
    {
      home_team_massey_line:       @home_team_massey_line,
      away_team_massey_line:       @away_team_massey_line,
      away_team_name:              @away_team_name,
      home_team_name:              @home_team_name,
      massey_over_under:           @massey_over_under,
      home_team_vegas_line_massey: @home_team_vegas_line_massey,
      away_team_vegas_line_massey: @away_team_vegas_line_massey,
      date:                        @date,
      sport:                       @sport
    }
  end

  def format_date
    date.gsub('/', '')
  end

  def get_home_team_massey_line(game)
    game[13].include?("ltgreen") ? game[13][0].to_f : game[12][0].to_f * -1
  end

  def home_team_vegas_line_massey(game)
    game[13].include?("ltred") ? game[13][0].to_f : game[12][0].to_f * -1
  end

  def create_instance_variables(game)
    @date                        =  date
    @home_team_massey_line       =  get_home_team_massey_line(game).to_f
    @away_team_massey_line       =  -get_home_team_massey_line(game).to_f
    @away_team_name              =  NameFormatter.new(game[2][0]).format_name
    @home_team_name              =  NameFormatter.new(game[3][0]).format_name
    @massey_over_under           =  game[14][0].to_f
    @home_team_vegas_line_massey = home_team_vegas_line_massey(game)
    @away_team_vegas_line_massey = home_team_vegas_line_massey(game) * -1
    @sport                       =  sport
  end
end
