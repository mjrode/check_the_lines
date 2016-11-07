class Games::MapNbaGame < Less::Interaction
	expects :team_name

	def run
		get_pregame_name
	end

	private

	def get_pregame_name
    teams[:"#{team_name}"]
	end

	def teams
		{
  	  "Atlanta": "Atlanta",
  		"Boston": "Boston",
      "Brooklyn": "Brooklyn",
      "Charlotte": "Charlotte",
      "Chicago": "Chicago",
      "Cleveland": "Cleveland",
      "Dallas": "Dallas",
      "Denver": "Denver",
      "Detroit": "Detroit",
      "Golden State": "Golden State",
      "Houston": "Houston",
      "Indiana": "Indiana",
      "LA Clippers": "Los Angeles Clippers",
		  "LA Lakers": "Los Angeles Lakers",
      "Memphis": "Memphis",
      "Miami": "Miami",
      "Milwaukee": "Milwaukee",
      "Minnesota": "Minnesota",
      "New Orleans": "New Orleans",
      "New York": "New York",
      "Oklahoma City": "Oklahoma",
      "Orlando": "Orlando",
      "Philadelphia": "Philadelphia",
      "Phoenix": "Phoenix",
      "Portland": "Portland",
      "Sacramento": "Sacramento",
      "San Antonio": "San Antonio",
      "Toronto": "Toronto",
      "Utah": "Utah",
      "Washington": "Washington"
		}
	end
end
