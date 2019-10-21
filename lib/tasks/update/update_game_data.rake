namespace :update do

  desc 'Fetch all Game Data'
  task :games, [:process_all_games, :do_not_fetch_data] => [:environment] do |task, args|
    puts "Process all games is set to #{!!args[:process_all_games]}"
    puts "Fetch data is set to #{!!args[:do_not_fetch_data]}"
    Jobs::FetchAndProcessCurrentData.run(process_all_games: !!args[:process_all_games], do_not_fetch_data: !!args[:do_not_fetch_data])
  end
end
