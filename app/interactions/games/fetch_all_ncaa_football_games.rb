class Games::FetchAllNcaaFootballGames < Less::Interaction

	def run
		param_hash.each do |game|
			Games::FetchAllGameData.run(url: game[:url], date: game[:date], sport: game[:sport], sportsbook_month: game[:sportsbook_month])
		end
	end

	private
	def param_hash
		[
			{ url: "http://www.masseyratings.com/cf/11604/games?dt=20160903", date: "3", sport: "ncaa_football", sportsbook_month: "september" },
			{ url: "http://www.masseyratings.com/cf/11604/games?dt=20160910", date: "10", sport: "ncaa_football", sportsbook_month: "september" },
			{ url: "http://www.masseyratings.com/cf/11604/games?dt=20160917", date: "17", sport: "ncaa_football", sportsbook_month: "september" },
			{ url: "http://www.masseyratings.com/cf/11604/games?dt=20160924", date: "24", sport: "ncaa_football", sportsbook_month: "september" },
			{ url: "http://www.masseyratings.com/cf/11604/games?dt=20160901", date: "1", sport: "ncaa_football", sportsbook_month: "october" },
			{ url: "http://www.masseyratings.com/cf/11604/games?dt=20160908", date: "8", sport: "ncaa_football", sportsbook_month: "october" },
			{ url: "http://www.masseyratings.com/cf/11604/games?dt=20160915", date: "15", sport: "ncaa_football", sportsbook_month: "october" },
			{ url: "http://www.masseyratings.com/cf/11604/games?dt=20160922", date: "22", sport: "ncaa_football", sportsbook_month: "october" },
			{ url: "http://www.masseyratings.com/cf/11604/games?dt=20160929", date: "29", sport: "ncaa_football", sportsbook_month: "october" },
			{ url: "http://www.masseyratings.com/cf/11604/games?dt=20160905", date: "05", sport: "ncaa_football", sportsbook_month: "november" },
			{ url: "http://www.masseyratings.com/cf/11604/games?dt=20160912", date: "12", sport: "ncaa_football", sportsbook_month: "november" }
		]
	end
end


