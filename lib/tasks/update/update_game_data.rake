namespace :update do

  desc 'Fetch all Game Data'
  task games: :environment do
    FetchGameData.new.fetch
  end
end
