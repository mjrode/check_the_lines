namespace :update do

  desc 'Fetch all Game Data'
  task games: :environment do
    Games::FetchTodaysData.run
    Games::ProcessGames.run
  end
end
