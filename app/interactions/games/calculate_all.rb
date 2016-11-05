class Games::CalculateAll < Less::Interaction
	def run
		calculate_all
	end
	
	def calculate_all
    Game.all.each {|game| Games::Calculate.run(game: game)}
	end
end
