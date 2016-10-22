class Lines
  def fetch_data
    puts "Fetching NCAA data"
    Games::Import.run(massey_url: 'http://www.masseyratings.com/pred.php?s=cf&sub=11604', sport: 'ncaa_football')
    puts "Successfully imported NCAA data!"
    puts "Fetching NFL data"
    Games::Import.run(url: 'http://www.masseyratings.com/pred.php?s=nfl', sport: 'nfl_football')
    puts "Successfully imported NFL data!"
    puts "Now go lose some money!"
  end
end
