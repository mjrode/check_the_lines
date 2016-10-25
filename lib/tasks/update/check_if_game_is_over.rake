namespace :update do
  desc 'Check status to see if Game is over'
  task game_over: :environment do
     Game.all.each do |game|
       CheckIfOver.new(game).game_over?
     end
  end

  desc 'Fetch all Game Data'
  task update_games: :environment do
    FetchGameData.new.fetch
  end
end
