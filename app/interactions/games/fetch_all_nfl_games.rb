class Games::FetchAllNflGames < Less::Interaction

	def run
		param_hash.each do |game|
			Games::FetchAllGameData.run(url: game[:url], date: game[:date], sport: game[:sport], sportsbook_month: game[:sportsbook_month])
		end
	end

	private
	def param_hash
		[
			{ url: "http://www.masseyratings.com/nfl/games?dt=20160911", date: "11", sport: "nfl", sportsbook_month: "september" },
			{ url: "http://www.masseyratings.com/nfl/games?dt=20160918", date: "18", sport: "nfl", sportsbook_month: "september" },
			{ url: "http://www.masseyratings.com/nfl/games?dt=20160925", date: "25", sport: "nfl", sportsbook_month: "september" },
			{ url: "http://www.masseyratings.com/nfl/games?dt=20161002", date: "2", sport: "nfl", sportsbook_month: "october" },
			{ url: "http://www.masseyratings.com/nfl/games?dt=20161009", date: "9", sport: "nfl", sportsbook_month: "october" },
			{ url: "http://www.masseyratings.com/nfl/games?dt=20161016", date: "16", sport: "nfl", sportsbook_month: "october" },
			{ url: "http://www.masseyratings.com/nfl/games?dt=20161023", date: "23", sport: "nfl", sportsbook_month: "october" },
			{ url: "http://www.masseyratings.com/nfl/games?dt=20161030", date: "30", sport: "nfl", sportsbook_month: "october" },
			{ url: "http://www.masseyratings.com/nfl/games?dt=20161106", date: "6", sport: "nfl", sportsbook_month: "november" },
			{ url: "http://www.masseyratings.com/nfl/games?dt=20161113", date: "13", sport: "nfl", sportsbook_month: "november" },
			{ url: "http://www.masseyratings.com/nfl/games?dt=20161120", date: "20", sport: "nfl", sportsbook_month: "november" },
			{ url: "http://www.masseyratings.com/nfl/games?dt=20161127", date: "27", sport: "nfl", sportsbook_month: "november" }
		]
	end
end


