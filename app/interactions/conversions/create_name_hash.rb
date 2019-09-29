


# require 'pry'

# class NameFormatter

#   def initialize(team_name)
#     @team_name = team_name
#   end

#   def reverse_name_format
#      @team_name = @team_name.gsub('State', 'St') if @team_name.include?('State')
#   end

#   def format_name
#     remove_at
#     format_direction
#     format_state
#     format_schools
#     @team_name
#   end

#   def remove_at
#     @team_name = @team_name.delete('@').strip
#   end

#   def format_state
#     @team_name = @team_name.gsub('St', 'State') if @team_name.include?('St')
#   end

#   def format_direction
#     @team_name = @team_name.gsub('W ', 'W. ')
#     @team_name = @team_name.gsub('S ', 'S. ')
#     @team_name = @team_name.gsub('E ', 'E. ')
#     @team_name = @team_name.gsub('N ', 'N. ')
#   end

#   def format_schools
#     format_nc_state
#     format_miami
#     format_miami_ohio
#     format_southern_miss
#     format_central_michigan
#     format_georgia_state
#     format_texas_state
#   end

#   def format_nc_state
#     @team_name = 'N.C. State' if @team_name == "NC State"
#   end

#   def format_miami
#     @team_name =  "Miami" if @team_name == 'Miami FL'
#   end

#   def format_miami_ohio
#     @team_name = "Miami (Ohio)" if @team_name == 'Miami OH'
#   end

#   def format_southern_miss
#     @team_name = "Southern Miss." if @team_name == "Southern Miss"
#   end

#   def format_central_michigan
#     @team_name = "Central Michigan" if @team_name == "C Michigan"
#   end

#   def format_georgia_state
#     @team_name = "Georgia State" if @team_name == "Georgia St."
#   end

#   def format_texas_state
#     @team_name = "Texas State" if @team_name == "Texas St."
#   end

#   def format_smu
#     @team_name = "Southern Methodist Mustangs" if @team_name == "SMU"
#   end
# end

# action_names = [
#   'Navy Midshipmen',
#   'Memphis Tigers',
#   'Virginia Tech Hokies',
#   'Duke Blue Devils',
#   'Penn State Nittany Lions',
#   'Maryland Terrapins',
#   'Air Force Falcons',
#   'San Jose State Spartans',
#   'California Bears',
#   'Arizona State Sun Devils',
#   'Kansas Jayhawks',
#   'TCU Horned Frogs',
#   'Northern Illinois Huskies',
#   'Vanderbilt Commodores',
#   'Texas A&M Aggies',
#   'Arkansas Razorbacks',
#   'Syracuse Orange',
#   'Holy Cross Crusaders',
#   'Buffalo Bulls',
#   'Miami (OH) RedHawks',
#   'Central Michigan Chippewas',
#   'Western Michigan Broncos',
#   'Rutgers Scarlet Knights',
#   'Michigan Wolverines',
#   'Oklahoma Sooners',
#   'Texas Tech Red Raiders',
#   'BYU Cougars',
#   'Toledo Rockets',
#   'Iowa Hawkeyes',
#   'Middle Tennessee Blue Raiders',
#   'Wisconsin Badgers',
#   'Northwestern Wildcats',
#   'Pittsburgh Panthers',
#   'Delaware Fightin Blue Hens',
#   'Charlotte 49ers',
#   'Florida Atlantic Owls',
#   'Minnesota Golden Gophers',
#   'Purdue Boilermakers',
#   'Alabama Crimson Tide',
#   'Ole Miss Rebels',
#   'Georgia Tech Yellow Jackets',
#   'Temple Owls',
#   'Clemson Tigers',
#   'North Carolina Tar Heels',
#   'USC Trojans',
#   'Washington Huskies',
#   'Massachusetts Minutemen',
#   'Akron Zips',
#   'Baylor Bears',
#   'Iowa State Cyclones',
#   'Appalachian State Mountaineers',
#   'Coastal Carolina Chanticleers',
#   'Wake Forest Demon Deacons',
#   'Boston College Eagles',
#   'Indiana Hoosiers',
#   'Michigan State Spartans',
#   'Virginia Cavaliers',
#   'Notre Dame Fighting Irish',
#   'Florida Gators',
#   'Towson Tigers',
#   'South Florida Bulls',
#   'Southern Methodist Mustangs',
#   'Cincinnati Bearcats',
#   'Marshall Thundering Herd',
#   'New Mexico Lobos',
#   'Liberty Flames',
#   'East Carolina Pirates',
#   'Old Dominion Monarchs',
#   'Arkansas State Red Wolves',
#   'Troy Trojans',
#   'Georgia Southern Eagles',
#   "Louisiana-Lafayette Ragin' Cajuns",
#   'Mississippi State Bulldogs',
#   'Auburn Tigers',
#   'Oregon State Beavers',
#   'Stanford Cardinal',
#   'Connecticut Huskies',
#   'UCF Knights',
#   'Western Kentucky Hilltoppers',
#   'UAB Blazers',
#   'Louisiana Tech Bulldogs',
#   'Rice Owls',
#   'Southern Miss Golden Eagles',
#   'UTEP Miners',
#   'Texas State Bobcats',
#   'Nicholls State Colonels',
#   'South Alabama Jaguars',
#   'Louisiana-Monroe Warhawks',
#   'Oklahoma State Cowboys',
#   'Kansas State Wildcats',
#   'Florida State Seminoles',
#   'North Carolina State Wolfpack',
#   'Ohio State Buckeyes',
#   'Nebraska Cornhuskers',
#   'South Carolina Gamecocks',
#   'Kentucky Wildcats',
#   'Utah State Aggies',
#   'Colorado State Rams',
#   'Fresno State Bulldogs',
#   'New Mexico State Aggies',
#   'Houston Cougars',
#   'North Texas Mean Green',
#   'UNLV Rebels',
#   'Wyoming Cowboys',
#   'Utah Utes',
#   'Washington State Cougars',
#   'Hawaii Warriors',
#   'Nevada Wolf Pack',
#   'UCLA Bruins',
#   'Arizona Wildcats'
# ]

# massey_names = [
#   'Navy',
#   '@ Memphis',
#   'Duke',
#   '@ Virginia Tech',
#   'Arizona St',
#   '@ California',
#   'Penn St',
#   '@ Maryland',
#   'San Jose St',
#   '@ Air Force',
#   'Rutgers',
#   '@ Michigan',
#   'N Illinois',
#   '@ Vanderbilt',
#   'Stanford',
#   '@ Oregon St',
#   'Iowa St',
#   '@ Baylor',
#   'Louisiana',
#   '@ Ga Southern',
#   'Kentucky',
#   '@ South Carolina',
#   'Texas Tech',
#   '@ Oklahoma',
#   'Ohio St',
#   '@ Nebraska',
#   'Kansas',
#   '@ TCU',
#   'Northwestern',
#   '@ Wisconsin',
#   'FL Atlantic',
#   '@ Charlotte',
#   'SMU',
#   '@ South Florida',
#   'Coastal Car',
#   '@ Appalachian St',
#   'C Michigan',
#   '@ W Michigan',
#   'Delaware',
#   '@ Pittsburgh',
#   'Holy Cross',
#   '@ Syracuse',
#   'Indiana',
#   '@ Michigan St',
#   'Akron',
#   '@ Massachusetts',
#   'Houston',
#   '@ North Texas',
#   'Buffalo',
#   '@ Miami OH',
#   'Colorado St',
#   '@ Utah St',
#   'Minnesota',
#   '@ Purdue',
#   'South Alabama',
#   '@ ULM',
#   'UAB',
#   '@ WKU',
#   'Kansas St',
#   '@ Oklahoma St',
#   'Wake Forest',
#   '@ Boston College',
#   'Fresno St',
#   '@ New Mexico St',
#   'MTSU',
#   '@ Iowa',
#   'Louisiana Tech',
#   '@ Rice',
#   'NC State',
#   '@ Florida St',
#   'Cincinnati',
#   '@ Marshall',
#   'New Mexico',
#   '@ Liberty',
#   'Connecticut',
#   '@ UCF',
#   'Virginia',
#   '@ Notre Dame',
#   'UNLV',
#   '@ Wyoming',
#   'Clemson',
#   '@ North Carolina',
#   'Mississippi',
#   '@ Alabama',
#   'UCLA',
#   '@ Arizona',
#   'Arkansas St',
#   '@ Troy',
#   'Mississippi St',
#   '@ Auburn',
#   'East Carolina',
#   '@ Old Dominion',
#   'UTEP',
#   '@ Southern Miss',
#   'Georgia Tech',
#   '@ Temple',
#   'Towson',
#   '@ Florida',
#   'USC',
#   '@ Washington',
#   'BYU',
#   '@ Toledo',
#   'Hawaii',
#   '@ Nevada',
#   'Nicholls St',
#   '@ Texas St',
#   'Washington St',
#   '@ Utah',
#   'Texas A&M',
#   'Arkansas'
# ]

# name_map = {}
# massey_names.each do |name|
#   formatted_name = NameFormatter.new(name).format_name
#   puts formatted_name
#   action_name =
#     action_names.select do |action_name|
#       action_name.downcase.include?(formatted_name.downcase)
#     end
#   puts action_name

#   name_map[formatted_name] = action_name
# end

# new_name_map = {}
# name_map.each do |k, v|
#   value =
#     if v.empty?
#       ''
#     elsif v.size == 1
#       v.first
#     else
#       v
#     end
#   new_name_map[k] = value
# end


# current_mapping = {"Navy"=>"Navy Midshipmen",
# "Memphis"=>"Memphis Tigers",
# "Duke"=>"Duke Blue Devils",
# "Virginia Tech"=>"Virginia Tech Hokies",
# "Arizona State"=>"Arizona State Sun Devils",
# "California"=>"California Bears",
# "Penn State"=>"Penn State Nittany Lions",
# "Maryland"=>"Maryland Terrapins",
# "San Jose State"=>"San Jose State Spartans",
# "Air Force"=>"Air Force Falcons",
# "Rutgers"=>"Rutgers Scarlet Knights",
# "Michigan"=>["Central Michigan Chippewas", "Western Michigan Broncos", "Michigan Wolverines", "Michigan State Spartans"],
# "N. Illinois"=>"Northern Illinois Huskies",
# "Vanderbilt"=>"Vanderbilt Commodores",
# "Stateanford"=>"Stanford Cardinal",
# "Oregon State"=>"Oregon State Beavers",
# "Iowa State"=>"Iowa State Cyclones",
# "Baylor"=>"Baylor Bears",
# "Louisiana"=>["Louisiana-Lafayette Ragin' Cajuns", "Louisiana Tech Bulldogs", "Louisiana-Monroe Warhawks"],
# "Ga Southern"=>"Georgia Southern Eagles",
# "Kentucky"=>["Western Kentucky Hilltoppers", "Kentucky Wildcats"],
# "South Carolina"=>"South Carolina Gamecocks",
# "Texas Tech"=>"Texas Tech Red Raiders",
# "Oklahoma"=>["Oklahoma Sooners", "Oklahoma State Cowboys"],
# "Ohio State"=>"Ohio State Buckeyes",
# "Nebraska"=>"Nebraska Cornhuskers",
# "Kansas"=>["Kansas Jayhawks", "Arkansas Razorbacks", "Arkansas State Red Wolves", "Kansas State Wildcats"],
# "TCU"=>"TCU Horned Frogs",
# "Northwestern"=>"Northwestern Wildcats",
# "Wisconsin"=>"Wisconsin Badgers",
# "FL Atlantic"=>"Florida Atlantic Owls",
# "Charlotte"=>"Charlotte 49ers",
# "SMU"=>"Southern Methodist Mustangs",
# "South Florida"=>"South Florida Bulls",
# "Coastal Car"=>"Coastal Carolina Chanticleers",
# "Appalachian State"=>"Appalachian State Mountaineers",
# "Central Michigan"=>"Central Michigan Chippewas",
# "W. Michigan"=>"Western Michigan Broncos",
# "Delaware"=>"Delaware Fightin Blue Hens",
# "Pittsburgh"=>"Pittsburgh Panthers",
# "Holy Cross"=>"Holy Cross Crusaders",
# "Syracuse"=>"Syracuse Orange",
# "Indiana"=>"Indiana Hoosiers",
# "Michigan State"=>"Michigan State Spartans",
# "Akron"=>"Akron Zips",
# "Massachusetts"=>"Massachusetts Minutemen",
# "Houston"=>"Houston Cougars",
# "North Texas"=>"North Texas Mean Green",
# "Buffalo"=>"Buffalo Bulls",
# "Miami (Ohio)"=>"Miami (OH) RedHawks",
# "Colorado State"=>"Colorado State Rams",
# "Utah State"=>"Utah State Aggies",
# "Minnesota"=>"Minnesota Golden Gophers",
# "Purdue"=>"Purdue Boilermakers",
# "South Alabama"=>"South Alabama Jaguars",
# "ULM"=>"Louisiana-Monroe Warhawks",
# "UAB"=>"UAB Blazers",
# "WKU"=>"Western Kentucky Hilltoppers",
# "Kansas State"=> "Kansas State Wildcats",
# "Oklahoma State"=>"Oklahoma State Cowboys",
# "Wake Forest"=>"Wake Forest Demon Deacons",
# "Boston College"=>"Boston College Eagles",
# "Fresno State"=>"Fresno State Bulldogs",
# "New Mexico State"=>"New Mexico State Aggies",
# "MTSU"=>"Middle Tennessee Blue Raiders",
# "Iowa"=>"Iowa Hawkeyes",
# "Louisiana Tech"=>"Louisiana Tech Bulldogs",
# "Rice"=>"Rice Owls",
# "NC Stateate"=>"North Carolina State Wolfpack",
# "Florida State"=>"Florida State Seminoles",
# "Cincinnati"=>"Cincinnati Bearcats",
# "Marshall"=>"Marshall Thundering Herd",
# "New Mexico"=>"New Mexico Lobos",
# "Liberty"=>"Liberty Flames",
# "Connecticut"=>"Connecticut Huskies",
# "UCF"=>"UCF Knights",
# "Virginia"=>"Virginia Cavaliers",
# "Notre Dame"=>"Notre Dame Fighting Irish",
# "UNLV"=>"UNLV Rebels",
# "Wyoming"=>"Wyoming Cowboys",
# "Clemson"=>"Clemson Tigers",
# "North Carolina"=>["North Carolina Tar Heels", "North Carolina State Wolfpack"],
# "Mississippi"=>"Mississippi State Bulldogs",
# "Alabama"=>"Alabama Crimson Tide",
# "UCLA"=>"UCLA Bruins",
# "Arizona"=> "Arizona Wildcats",
# "Arkansas State"=>"Arkansas State Red Wolves",
# "Troy"=>"Troy Trojans",
# "Mississippi State"=>"Mississippi State Bulldogs",
# "Auburn"=>"Auburn Tigers",
# "East Carolina"=>"East Carolina Pirates",
# "Old Dominion"=>"Old Dominion Monarchs",
# "UTEP"=>"UTEP Miners",
# "Southern Miss."=>"Southern Miss Golden Eagles",
# "Georgia Tech"=>"Georgia Tech Yellow Jackets",
# "Temple"=>"Temple Owls",
# "Towson"=>"Towson Tigers",
# "Florida"=>["Florida Atlantic Owls", "Florida Gators", "South Florida Bulls", "Florida State Seminoles"],
# "USC"=>"USC Trojans",
# "Washington"=>"Washington Huskies",
# "BYU"=>"BYU Cougars",
# "Toledo"=>"Toledo Rockets",
# "Hawaii"=>"Hawaii Warriors",
# "Nevada"=>"Nevada Wolf Pack",
# "Nicholls State"=>"Nicholls State Colonels",
# "Texas State"=>"Texas State Bobcats",
# "Washington State"=>"Washington State Cougars",
# "Utah"=> "Utah Utes",
# "Texas A&M"=>"Texas A&M Aggies",
# "Arkansas"=>"Arkansas Razorbacks"}

# old_mapping = {
#  "utah"=>"utah utes",
#  "e. michigan"=>"eastern michigan eagles",
#  "w. michigan"=>"western michigan broncos",
#  "duke"=>"duke blue devils",
#  "tulane"=>"tulane green wave",
#  "minnesota"=>"minnesota golden gophers",
#  "san jose st."=>"san jose state spartans",
#  "michigan st."=>"michigan state spartans",
#  "ball st."=>"ball state cardinals",
#  "purdue"=>"purdue boilermakers",
#  "wisconsin"=>"wisconsin badgers",
#  "connecticut"=>"connecticut huskies",
#  "smu"=>"Southern Methodist Mustangs",
#  "syracuse"=>"syracuse orange",
#  "utah st."=>"utah state aggies",
#  "wake forest"=>"wake forest demon deacons",
#  "weber st."=>"weber state wildcats",
#  "army"=>"army black knights",
#  "uc davis"=>"uc davis aggies",
#  "northwestern"=>"northwestern wildcats",
#  "se. louisiana"=>"southeastern louisiana lions",
#  "monmouth nj"=>"monmouth hawks",
#  "ucf"=>"ucf knights",
#  "central conn"=>"central connecticut state blue devils",
#  "wku"=>"western kentucky hilltoppers",
#  "vanderbilt"=>"vanderbilt commodores",
#  "alabama"=>"alabama crimson tide",
#  "pittsburgh"=>"pittsburgh panthers",
#  "liberty"=>"liberty flames",
#  "virginia"=>"virginia cavaliers",
#  "louisiana-monroe"=>"louisiana-monroe warhawks",
#  "maryland"=>"maryland terrapins",
#  "arkansas st."=>"arkansas state red wolves",
#  "notre dame"=>"notre dame fighting irish",
#  "rice"=>"rice owls",
#  "lsu"=>"lsu tigers",
#  "california"=>"california bears",
#  "massachusetts"=>"massachusetts minutemen",
#  "oregon"=>"oregon ducks",
#  "temple"=>"temple owls",
#  "south carolina"=>"south carolina gamecocks",
#  "kansas"=>"kansas jayhawks",
#  "texas tech"=>"texas tech red raiders",
#  "fresno st."=>"fresno state bulldogs",
#  "tennessee"=>"tennessee volunteers",
#  "miami (ohio)"=>"miami (oh) redhawks",
#  "usc"=>"usc trojans",
#  "east carolina"=>"east carolina pirates",
#  "auburn"=>"auburn tigers",
#  "tulsa"=>"tulsa golden hurricane",
#  "memphis"=>"memphis tigers",
#  "boston college"=>"boston college eagles",
#  "ucla"=>"ucla bruins",
#  "south florida"=>"south florida bulls",
#  "florida intl"=>"florida international golden panthers",
#  "kentucky"=>"kentucky wildcats",
#  "nebraska"=>"nebraska cornhuskers",
#  "ohio st."=>"ohio state buckeyes",
#  "new mexico"=>"new mexico lobos",
#  "hawaii"=>"hawaii warriors",
#  "charlotte"=>"charlotte 49ers",
#  "arizona"=>"arizona wildcats",
#  "oklahoma"=>"oklahoma sooners",
#  "north texas"=>"north texas mean green",
#  "florida st."=>"florida state seminoles",
#  "north carolina st."=>"north carolina state wolfpack",
#  "south alabama"=>"south alabama jaguars",
#  "kansas st."=>"kansas state wildcats",
#  "illinois"=>"illinois fighting illini",
#  "colorado st."=>"colorado state rams",
#  "stanford"=>"stanford cardinal",
#  "rutgers"=>"rutgers scarlet knights",
#  "iowa"=>"iowa hawkeyes",
#  "penn st."=>"penn state nittany lions",
#  "nevada"=>"nevada wolf pack",
#  "wyoming"=>"wyoming cowboys",
#  "arizona st."=>"arizona state sun devils",
#  "new mexico st."=>"new mexico state aggies",
#  "air force"=>"air force falcons",
#  "troy"=>"troy trojans",
#  "iowa st."=>"iowa state cyclones",
#  "kent"=>"kent state golden flashes",
#  "washington"=>"washington huskies",
#  "appalachian st."=>"appalachian state mountaineers",
#  "texas"=>"texas longhorns",
#  "bowling green"=>"bowling green falcons",
#  "michigan"=>"michigan wolverines",
#  "colorado"=>"colorado buffaloes",
#  "houston"=>"houston cougars",
#  "akron"=>"akron zips",
#  "villanova"=>"villanova wildcats",
#  "san diego st."=>"san diego state aztecs",
#  "navy"=>"navy midshipmen",
#  "mercer"=>"mercer bears",
#  "florida atlantic"=>"florida atlantic owls",
#  "unlv"=>"unlv rebels",
#  "texas state"=>"texas state bobcats",
#  "south carolina st."=>"south carolina state bulldogs",
#  "coastal car"=>"coastal carolina chanticleers",
#  "fordham"=>"fordham rams",
#  "byu"=>"byu cougars",
#  "north carolina a&t"=>"north carolina a&t aggies",
#  "incarnate word"=>"incarnate word cardinals",
#  "marshall"=>"marshall thundering herd",
#  "washington st."=>"washington state cougars",
#  "james madison"=>"james madison dukes",
#  "n. illinois"=>"northern illinois huskies",
#  "albany"=>"albany great danes",
#  "louisiana tech"=>"louisiana tech bulldogs",
#  "middle tennessee"=>"middle tennessee blue raiders",
#  "south dakota"=>"south dakota coyotes",
#  "elon"=>"elon phoenix",
#  "louisville"=>"louisville cardinals",
#  "duquesne"=>"duquesne dukes",
#  "cincinnati"=>"cincinnati bearcats",
#  "ole miss"=>"ole miss rebels",
#  "central michigan"=>"central michigan chippewas",
#  "stony brook"=>"stony brook seawolves",
#  "virginia tech"=>"virginia tech hokies",
#  "west virginia"=>"west virginia mountaineers",
#  "north carolina"=>"north carolina tar heels",
#  "south dakota st."=>"south dakota state jackrabbits",
#  "miami"=>"miami (fl) hurricanes",
#  "old dominion"=>"old dominion monarchs",
#  "s. methodist"=>"southern methodist mustangs",
#  "prairie view a&m"=>"prairie view a&m panthers",
#  "oregon st."=>"oregon state beavers",
#  "nicholls st."=>"nicholls state colonels",
#  "idaho"=>"idaho vandals",
#  "boise st."=>"boise state broncos",
#  "indiana"=>"indiana hoosiers"
# }

# formatted_old_mapping = {}
# old_mapping.each do |k,v|
#   formatted_old_mapping[NameFormatter.new(k).reverse_name_format] = v
# end


# binding.pry
# puts "hi"