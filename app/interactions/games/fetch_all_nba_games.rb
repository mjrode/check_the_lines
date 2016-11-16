class Games::FetchAllNbaGames < Less::Interaction

	def run
		param_hash.each do |game|
			Games::FetchAllGameData.run(url: game[:url], date: game[:date], sport: game[:sport], sportsbook_month: game[:sportsbook_month])
		end
	end

	private
	def param_hash
		[
			{ url: "http://www.masseyratings.com/nba/games?dt=20161025", date: "25", sport: "nba", sportsbook_month: "october"},
			{ url: "http://www.masseyratings.com/nba/games?dt=20161026", date: "26", sport: "nba", sportsbook_month: "october"},
			{ url: "http://www.masseyratings.com/nba/games?dt=20161027", date: "27", sport: "nba", sportsbook_month: "october"},
			{ url: "http://www.masseyratings.com/nba/games?dt=20161028", date: "28", sport: "nba", sportsbook_month: "october"},
			{ url: "http://www.masseyratings.com/nba/games?dt=20161029", date: "29", sport: "nba", sportsbook_month: "october"},
			{ url: "http://www.masseyratings.com/nba/games?dt=20161030", date: "30", sport: "nba", sportsbook_month: "october"},
			{ url: "http://www.masseyratings.com/nba/games?dt=20161031", date: "31", sport: "nba", sportsbook_month: "october"},
			{ url: "http://www.masseyratings.com/nba/games?dt=20161101", date: "1", sport: "nba", sportsbook_month: "november"},
			{ url: "http://www.masseyratings.com/nba/games?dt=20161102", date: "2", sport: "nba", sportsbook_month: "november"},
			{ url: "http://www.masseyratings.com/nba/games?dt=20161103", date: "3", sport: "nba", sportsbook_month: "november"},
			{ url: "http://www.masseyratings.com/nba/games?dt=20161104", date: "4", sport: "nba", sportsbook_month: "november"},
			{ url: "http://www.masseyratings.com/nba/games?dt=20161105", date: "5", sport: "nba", sportsbook_month: "november"},
			{ url: "http://www.masseyratings.com/nba/games?dt=20161106", date: "6", sport: "nba", sportsbook_month: "november"},
			{ url: "http://www.masseyratings.com/nba/games?dt=20161107", date: "7", sport: "nba", sportsbook_month: "november"},
			{ url: "http://www.masseyratings.com/nba/games?dt=20161108", date: "8", sport: "nba", sportsbook_month: "november"},
			{ url: "http://www.masseyratings.com/nba/games?dt=20161109", date: "9", sport: "nba", sportsbook_month: "november"},
			{ url: "http://www.masseyratings.com/nba/games?dt=20161110", date: "10", sport: "nba", sportsbook_month: "november"},
			{ url: "http://www.masseyratings.com/nba/games?dt=20161111", date: "11", sport: "nba", sportsbook_month: "november"},
			{ url: "http://www.masseyratings.com/nba/games?dt=20161112", date: "12", sport: "nba", sportsbook_month: "november"},
		]
	end
end


