class Conversions::MapNflTeam < Less::Interaction
	expects :team_name

	def run
		get_pregame_name
	end

	private

	def get_pregame_name
    teams[:"#{team_name}"] || team_name
	end

	def teams
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

  
  
