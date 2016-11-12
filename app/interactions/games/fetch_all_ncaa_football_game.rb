class Games::FetchAllNbaGames < Less::Interaction

	def run
		param_hash.each do |game|
			Games::FetchAllGameData.run(url: game[:url], date: game[:date], sport: game[:sport], last_month: game[:last_month])
		end
	end

	private
	def param_hash
		[
			{ url: "http://www.masseyratings.com/cf/11604/games?dt=20160830", date: "25", sport: "ncaa_football", last_month: true },
			{url: "http://www.masseyratings.com/nba/games?dt=20161009", date: "09", sport: "nba"}
		]
	end
end


