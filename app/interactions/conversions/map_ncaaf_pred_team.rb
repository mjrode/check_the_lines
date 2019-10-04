class Conversions::MapNcaafPredTeam < Less::Interaction
expects :team_name
expects :missing_name_map, allow_nil: true

  def run
    format_name
  end

  private

  def format_name
    if team_name_mapping[team_name]
      team_name_mapping["#{team_name}"]
    else
      puts "Unable to find mapping for #{team_name}"
      missing_name_map << team_name if missing_name_map
      team_name
    end
  end

  def team_name_mapping
    {"Air Force"=>"Air Force Falcons",
    "Arizona"=>"Arizona Wildcats",
    "Arkansas St."=>"Arkansas State Red Wolves",
    "Army"=>"Army Black Knights",
    "Auburn"=>"Auburn Tigers",
    "Ball St."=>"Ball State Cardinals",
    "Baylor"=>"Baylor Bears",
    "Boise St."=>"Boise State Broncos",
    "Boston College"=>"Boston College Eagles",
    "Bowling Green"=>"Bowling Green Falcons",
    "Buffalo"=>"Buffalo Bulls",
    "California"=>"California Bears",
    "Central Florida"=>'UCF Knights',
    "Central Mich."=> 'Central Michigan Chippewas',
    "Cincinnati"=>"Cincinnati Bearcats",
    "Colorado"=>"Colorado Buffaloes",
    "Colorado St."=>"Colorado State Rams",
    "Connecticut"=>"Connecticut Huskies",
    "Duke"=>"Duke Blue Devils",
    "East Carolina"=>"East Carolina Pirates",
    "Eastern Mich."=>'Eastern Michigan Eagles',
    "Florida"=>"Florida Gators",
    "Florida Intl."=>"Florida International Golden Panthers",
    "Georgia"=>"Georgia Bulldogs",
    "Georgia St."=>"Georgia State Panthers",
    "Georgia Tech"=>"Georgia Tech Yellow Jackets",
    "Illinois"=>"Illinois Fighting Illini",
    "Iowa"=>"Iowa Hawkeyes",
    "Iowa St."=>"Iowa State Cyclones",
    "Kansas"=>"Kansas Jayhawks",
    "Kansas St."=>"Kansas State Wildcats",
    "Kent"=>"Kent State Golden Flashes",
    "LSU"=>"LSU Tigers",
    "Liberty"=>"Liberty Flames",
    "Louisiana-Monroe"=>'Louisiana-Monroe Warhawks',
    "Louisville"=>"Louisville Cardinals",
    "Marshall"=>"Marshall Thundering Herd",
    "Maryland"=>"Maryland Terrapins",
    "Massachusetts"=>"Massachusetts Minutemen",
    "Memphis"=>"Memphis Tigers",
    "Miami (Fla.)"=>'Miami (FL) Hurricanes',
    "Michigan"=>"Michigan Wolverines",
    "Michigan St."=>"Michigan State Spartans",
    "Middle Tenn."=>'Middle Tennessee Blue Raiders',
    "Minnesota"=>"Minnesota Golden Gophers",
    "Mississippi"=>"Mississippi State Bulldogs",
    "Missouri"=>"Missouri Tigers",
    "Navy"=>"Navy Midshipmen",
    "Nebraska"=>"Nebraska Cornhuskers",
    "New Mexico"=>"New Mexico Lobos",
    "New Mexico St."=>"New Mexico State Aggies",
    "North Carolina"=>"North Carolina Tar Heels",
    "Northern Ill."=>'Northern Illinois Huskies',
    "Northwestern"=>"Northwestern Wildcats",
    "Notre Dame"=>"Notre Dame Fighting Irish",
    "Ohio"=>"Ohio State Buckeyes",
    "Ohio St."=>"Ohio State Buckeyes",
    "Oklahoma"=>"Oklahoma Sooners",
    "Oklahoma St."=>"Oklahoma State Cowboys",
    "Old Dominion"=>"Old Dominion Monarchs",
    "Oregon"=>"Oregon Ducks",
    "Oregon St."=>"Oregon State Beavers",
    "Penn St."=>"Penn State Nittany Lions",
    "Pittsburgh"=>"Pittsburgh Panthers",
    "Purdue"=>"Purdue Boilermakers",
    "Rice"=>"Rice Owls",
    "Rutgers"=>"Rutgers Scarlet Knights",
    "SMU"=>"Southern Methodist Mustangs",
    "San Diego St."=>"San Diego State Aztecs",
    "San Jose St."=>"San Jose State Spartans",
    "South Alabama"=>"South Alabama Jaguars",
    "South Florida"=>"South Florida Bulls",
    "Stanford"=>"Stanford Cardinal",
    "TCU"=>"TCU Horned Frogs",
    "Temple"=>"Temple Owls",
    "Tennessee"=>"Tennessee Volunteers",
    "Texas"=>"Texas Longhorns",
    "Texas Tech"=>"Texas Tech Red Raiders",
    "Texas-San Antonio"=>nil,
    "Toledo"=>"Toledo Rockets",
    "Troy St."=>'Troy Trojans',
    "Tulane"=>"Tulane Green Wave",
    "Tulsa"=>"Tulsa Golden Hurricane",
    "UAB"=>"UAB Blazers",
    "UCLA"=>"UCLA Bruins",
    "UNLV"=>"UNLV Rebels",
    "UTEP"=>"UTEP Miners",
    "Utah St."=>"Utah State Aggies",
    "Vanderbilt"=>"Vanderbilt Commodores",
    "Virginia Tech"=>"Virginia Tech Hokies",
    "Washington"=>"Washington Huskies",
    "West Va."=>'West Virginia Mountaineers',
    "Western Kentucky"=>'Western Kentucky Hilltoppers',
    "Western Mich."=>'Western Michigan Broncos',
    "Wisconsin"=>"Wisconsin Badgers"}
  end
end
