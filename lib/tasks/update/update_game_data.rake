namespace :update do

  desc 'Fetch all Game Data'
  task games: :environment do
    Jobs::ProcessCurrentData.run
  end
end
