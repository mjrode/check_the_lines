puts 'Loading Rails ENV'
system("heroku run bundle exec rails runner \"eval(File.read '/Users/MichaelRode/less/my_projects/check_the_lines/app/scripts/run_interactions.rb')\"")

