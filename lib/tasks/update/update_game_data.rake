namespace :update do

  desc 'Fetch all Game Data'
  task :games, [:process_all_games] => [:environment] do |task, args|
    Jobs::ProcessCurrentData.run(process_all_games: !!args[:process_all_games])
  end
end
