class Games::ProcessGames < Less::Interaction
	def run
    process
	end

	def process
    Games::CreateGameRecord.run
    Games::CalculateAll.run
	end
end
