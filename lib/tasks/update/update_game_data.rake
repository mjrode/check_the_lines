namespace :update do

  desc 'Fetch all Game Data'
  task games: :environment do
    Game.not_over.each do {|game| Games::Caluculate.run(game)}
    Games::FetchTodaysData.run
    Games::ProcessGames.run
  end
end
