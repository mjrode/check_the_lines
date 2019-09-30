class Conversions::MapNflTeam < Less::Interaction
	expects :team_name

	def run
		get_pregame_name
	end

	private

	def get_pregame_name
    teams["#{team_name}"] || team_name
  end

  def teams
    {"Green Bay"=>"Green Bay Packers", "Philadelphia"=>"Philadelphia Eagles", "Atlanta"=>"Atlanta Falcons", "Tennessee"=>"Tennessee Titans", "Baltimore"=>"Baltimore Ravens", "Cleveland"=>"Cleveland Browns", "Buffalo"=>"Buffalo Bills", "New England"=>"New England Patriots", "Detroit"=>"Detroit Lions", "Kansas City"=>"Kansas City Chiefs", "Houston"=>"Houston Texans", "Carolina"=>"Carolina Panthers", "Indianapolis"=>"Indianapolis Colts", "Oakland"=>"Oakland Raiders", "Miami"=>"Miami Dolphins", "LA Chargers"=>"", "NY Giants"=>"", "Washington"=>"Washington Redskins", "Arizona"=>"Arizona Cardinals", "Seattle"=>"Seattle Seahawks", "LA Rams"=>"", "Tampa Bay"=>"Tampa Bay Buccaneers", "Chicago"=>"Chicago Bears", "Minnesota"=>"Minnesota Vikings", "Denver"=>"Denver Broncos", "Jacksonville"=>"Jacksonville Jaguars", "New Orleans"=>"New Orleans Saints", "Dallas"=>"Dallas Cowboys", "Pittsburgh"=>"Pittsburgh Steelers", "Cincinnati"=>"Cincinnati Bengals"}
  end

	def old_teams
    {
      "LA Rams	" => "Los Angeles Rams",
      "Atlanta" => "Atlanta Falcons",
      "Buffalo" => "Buffalo Bills",
      "Pittsburgh" => "Pittsburgh Steelers",
      "Cincinnati" => "Cincinnati Bengals",
      "Tennessee" => "Tennessee Titans",
      "San Francisco" => "San Francisco 49ers",
      "Houston" => "Houston Texans",
      "Tampa Bay" => "Tampa Bay Buccaneers",
      "Jacksonville" => "Jacksonville Jaguars",
      "Kansas City" => "Kansas City Chiefs",
      "Washington" => "Washington Redskins",
      "Dallas" => "Dallas Cowboys",
      "Seattle" => "Seattle Seahawks",
      "Chicago" => "Chicago Bears",
      "NY Jets" => "New York Jets",
      "Oakland" => "Oakland Raiders",
      "Philadelphia" => "Philadelphia Eagles",
      "Baltimore" => "Baltimore Ravens",
      "Cleveland" => "Cleveland Browns",
      "Indianapolis" => "",
      "Miami" => "Miami Dolphins",
      "Minnesota" => "Minnesota Vikings",
      "New England" => "New England Patriots",
      "New Orleans" => "New Orleans Saints",
      "NY Giants" => "New York Giants",
      "LA Chargers" => "Los Angeles Chargers",
      "Arizona" => "Arizona Cardinals",
      "Carolina" => "Carolina Panthers",
      "Denver" => "Denver Broncos",
      "Green Bay" => "Green Bay Packers",
      "Detroit" => "Detroit Lions"
      }
	end
end
