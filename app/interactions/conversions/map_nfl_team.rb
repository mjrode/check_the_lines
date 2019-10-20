class Conversions::MapNflTeam < Less::Interaction
  expects :team_name

  def run
    get_pregame_name
  end

  private

  def get_pregame_name
    formatted_team_name =
      if teams[team_name]
        teams[team_name]
      else
        puts "Unable to format NFL name #{team_name}" unless Rails.env.test?
        team_name
      end
    formatted_team_name
  end

  def teams
    {
      'Green Bay' => 'Green Bay Packers',
      'Philadelphia' => 'Philadelphia Eagles',
      'Atlanta' => 'Atlanta Falcons',
      'Tennessee' => 'Tennessee Titans',
      'Baltimore' => 'Baltimore Ravens',
      'Cleveland' => 'Cleveland Browns',
      'Buffalo' => 'Buffalo Bills',
      'New England' => 'New England Patriots',
      'Detroit' => 'Detroit Lions',
      'Kansas City' => 'Kansas City Chiefs',
      'Houston' => 'Houston Texans',
      'Carolina' => 'Carolina Panthers',
      'Indianapolis' => 'Indianapolis Colts',
      'Oakland' => 'Oakland Raiders',
      'Miami' => 'Miami Dolphins',
      'LA Chargers' => 'Los Angeles Chargers',
      'NY Giants' => 'New York Giants',
      'Washington' => 'Washington Redskins',
      'Arizona' => 'Arizona Cardinals',
      'Seattle' => 'Seattle Seahawks',
      'LA Rams' => 'Los Angeles Rams',
      'Tampa Bay' => 'Tampa Bay Buccaneers',
      'Chicago' => 'Chicago Bears',
      'Minnesota' => 'Minnesota Vikings',
      'Denver' => 'Denver Broncos',
      'Jacksonville' => 'Jacksonville Jaguars',
      'New Orleans' => 'New Orleans Saints',
      'Dallas' => 'Dallas Cowboys',
      'Pittsburgh' => 'Pittsburgh Steelers',
      'Cincinnati' => 'Cincinnati Bengals',
      'San Francisco' => 'San Francisco 49ers',
      'NY Jets' => 'New York Jets'
    }
  end
end
