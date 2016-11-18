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
			{ url: "http://www.masseyratings.com/cb/11590/games?dt=20161117", date: "17", sport: "ncaa_basketball", sportsbook_month: "november"}
		]
	end
end


