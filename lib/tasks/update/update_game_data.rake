namespace :update do

  desc 'Fetch all Game Data'
  task games: :environment do
    Game.not_over.each {|game| Games::Calculate.run(game: game)}
    Games::FetchTodaysData.run
    Games::ProcessGames.run
  end
end
