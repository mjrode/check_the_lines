class Games::ProcessGames < Less::Interaction
	def run
    process
	end

	def process
    Games::ImportGameData.run
    Games::CalculateAll.run
	end
end
