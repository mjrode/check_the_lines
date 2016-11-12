class Games::FetchAllNbaGames < Less::Interaction

	def run
		param_hash.each do |game|
			Games::FetchAllGameData.run(url: game[:url], date: game[:date], sport: game[:sport], last_month: game[:last_month])
		end
	end

	private
	def param_hash
		[
			{ url: "http://www.masseyratings.com/nba/games?dt=20161025", date: "25", sport: "nba", last_month: true },
			{ url: "http://www.masseyratings.com/nba/games?dt=20161026", date: "26", sport: "nba", last_month: true },
			{ url: "http://www.masseyratings.com/nba/games?dt=20161027", date: "27", sport: "nba", last_month: true },
			{ url: "http://www.masseyratings.com/nba/games?dt=20161028", date: "28", sport: "nba", last_month: true },
			{ url: "http://www.masseyratings.com/nba/games?dt=20161029", date: "29", sport: "nba", last_month: true },
			{ url: "http://www.masseyratings.com/nba/games?dt=20161030", date: "30", sport: "nba", last_month: true },
			{ url: "http://www.masseyratings.com/nba/games?dt=20161031", date: "31", sport: "nba", last_month: true },
			{ url: "http://www.masseyratings.com/nba/games?dt=20161001", date: "01", sport: "nba"},
			{ url: "http://www.masseyratings.com/nba/games?dt=20161002", date: "02", sport: "nba"},
			{ url: "http://www.masseyratings.com/nba/games?dt=20161003", date: "03", sport: "nba"},
			{ url: "http://www.masseyratings.com/nba/games?dt=20161004", date: "04", sport: "nba"},
			{ url: "http://www.masseyratings.com/nba/games?dt=20161005", date: "05", sport: "nba"},
			{ url: "http://www.masseyratings.com/nba/games?dt=20161006", date: "06", sport: "nba"},
			{ url: "http://www.masseyratings.com/nba/games?dt=20161007", date: "07", sport: "nba"},
			{ url: "http://www.masseyratings.com/nba/games?dt=20161008", date: "08", sport: "nba"},
			{ url: "http://www.masseyratings.com/nba/games?dt=20161009", date: "09", sport: "nba"}
		]
	end
end


