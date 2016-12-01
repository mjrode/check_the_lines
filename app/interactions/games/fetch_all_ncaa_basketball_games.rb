class Games::FetchAllNcaaBasketballGames< Less::Interaction

	def run
		param_hash.each do |game|
			Games::FetchAllGameData.run(url: game[:url], date: game[:date], sport: game[:sport], sportsbook_month: game[:sportsbook_month])
		end
    Games::GameOver.run
    Games::FetchFinalScore.run()
		Games::CalculateAll.run()
	end

	private

	def param_hash
		[
			{ url: "http://www.masseyratings.com/cb/11590/games?dt=20161114", date: "14", sport: "ncaa_basketball", sportsbook_month: "november"},
			{ url: "http://www.masseyratings.com/cb/11590/games?dt=20161115", date: "15", sport: "ncaa_basketball", sportsbook_month: "november"},
			{ url: "http://www.masseyratings.com/cb/11590/games?dt=20161116", date: "16", sport: "ncaa_basketball", sportsbook_month: "november"},
			{ url: "http://www.masseyratings.com/cb/11590/games?dt=20161117", date: "17", sport: "ncaa_basketball", sportsbook_month: "november"},
			{ url: "http://www.masseyratings.com/cb/11590/games?dt=20161118", date: "18", sport: "ncaa_basketball", sportsbook_month: "november"},
			{ url: "http://www.masseyratings.com/cb/11590/games?dt=20161119", date: "19", sport: "ncaa_basketball", sportsbook_month: "november"},
			{ url: "http://www.masseyratings.com/cb/11590/games?dt=20161120", date: "20", sport: "ncaa_basketball", sportsbook_month: "november"},
			{ url: "http://www.masseyratings.com/cb/11590/games?dt=20161121", date: "21", sport: "ncaa_basketball", sportsbook_month: "november"},
			{ url: "http://www.masseyratings.com/cb/11590/games?dt=20161122", date: "22", sport: "ncaa_basketball", sportsbook_month: "november"},
			{ url: "http://www.masseyratings.com/cb/11590/games?dt=20161123", date: "23", sport: "ncaa_basketball", sportsbook_month: "november"},
			{ url: "http://www.masseyratings.com/cb/11590/games?dt=20161124", date: "24", sport: "ncaa_basketball", sportsbook_month: "november"},
			{ url: "http://www.masseyratings.com/cb/11590/games?dt=20161125", date: "25", sport: "ncaa_basketball", sportsbook_month: "november"},
			{ url: "http://www.masseyratings.com/cb/11590/games?dt=20161126", date: "26", sport: "ncaa_basketball", sportsbook_month: "november"},
			{ url: "http://www.masseyratings.com/cb/11590/games?dt=20161127", date: "27", sport: "ncaa_basketball", sportsbook_month: "november"},
			{ url: "http://www.masseyratings.com/cb/11590/games?dt=20161128", date: "28", sport: "ncaa_basketball", sportsbook_month: "november"},
			{ url: "http://www.masseyratings.com/cb/11590/games?dt=20161129", date: "29", sport: "ncaa_basketball", sportsbook_month: "november"}
		]
	end
end


