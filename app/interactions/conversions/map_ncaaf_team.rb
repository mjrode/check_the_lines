class Conversions::MapNcaafTeam < Less::Interaction
  expects :team_name
  expects :missing_name_map, allow_nil: true

  def run
    format_name
  end

  private

  def format_name
    if team_name_mapping[team_name]
      team_name_mapping[team_name]
    else
      puts "Unable to find mapping for #{team_name}" unless Rails.env.test?
      missing_name_map << team_name
      team_name
    end
  end

  def team_name_mapping
    {
      'Navy' => 'Navy Midshipmen',
      'Memphis' => 'Memphis Tigers',
      'North Carolina A&T' => 'North Carolina A&T Aggies',
      'San Diego St' => 'San Diego State Aztecs',
      'Illinois' => 'Illinois Fighting Illini',
      'Duke' => 'Duke Blue Devils',
      'Colorado' => 'Colorado Buffaloes',
      'Oregon' => 'Oregon Ducks',
      'Virginia Tech' => 'Virginia Tech Hokies',
      'Arizona St' => 'Arizona State Sun Devils',
      'California' => 'California Bears',
      'Penn St' => 'Penn State Nittany Lions',
      'Maryland' => 'Maryland Terrapins',
      'San Jose St' => 'San Jose State Spartans',
      'Air Force' => 'Air Force Falcons',
      'Rutgers' => 'Rutgers Scarlet Knights',
      'Michigan' => 'Michigan Wolverines',
      'N Illinois' => 'Northern Illinois Huskies',
      'Vanderbilt' => 'Vanderbilt Commodores',
      'Stanford' => 'Stanford Cardinal',
      'Oregon St' => 'Oregon State Beavers',
      'Iowa St' => 'Iowa State Cyclones',
      'Baylor' => 'Baylor Bears',
      'Louisiana' => "Louisiana-Lafayette Ragin' Cajuns",
      'Ga Southern' => 'Georgia Southern Eagles',
      'Kentucky' => 'Kentucky Wildcats',
      'South Carolina' => 'South Carolina Gamecocks',
      'Texas Tech' => 'Texas Tech Red Raiders',
      'Oklahoma' => 'Oklahoma Sooners',
      'Ohio St' => 'Ohio State Buckeyes',
      'Nebraska' => 'Nebraska Cornhuskers',
      'Kansas' => 'Kansas Jayhawks',
      'TCU' => 'TCU Horned Frogs',
      'Northwestern' => 'Northwestern Wildcats',
      'Wisconsin' => 'Wisconsin Badgers',
      'FL Atlantic' => 'Florida Atlantic Owls',
      'Charlotte' => 'Charlotte 49ers',
      'SMU' => 'Southern Methodist Mustangs',
      'South Florida' => 'South Florida Bulls',
      'Coastal Car' => 'Coastal Carolina Chanticleers',
      'Appalachian St' => 'Appalachian State Mountaineers',
      'C Michigan' => 'Central Michigan Chippewas',
      'W Michigan' => 'Western Michigan Broncos',
      'Delaware' => 'Delaware Fightin Blue Hens',
      'Pittsburgh' => 'Pittsburgh Panthers',
      'Holy Cross' => 'Holy Cross Crusaders',
      'Syracuse' => 'Syracuse Orange',
      'Indiana' => 'Indiana Hoosiers',
      'Michigan St' => 'Michigan State Spartans',
      'Akron' => 'Akron Zips',
      'Massachusetts' => 'Massachusetts Minutemen',
      'Houston' => 'Houston Cougars',
      'North Texas' => 'North Texas Mean Green',
      'Buffalo' => 'Buffalo Bulls',
      'Miami OH' => 'Miami (OH) RedHawks',
      'Colorado St' => 'Colorado State Rams',
      'Utah St' => 'Utah State Aggies',
      'Minnesota' => 'Minnesota Golden Gophers',
      'Purdue' => 'Purdue Boilermakers',
      'South Alabama' => 'South Alabama Jaguars',
      'ULM' => 'Louisiana-Monroe Warhawks',
      'UAB' => 'UAB Blazers',
      'WKU' => 'Western Kentucky Hilltoppers',
      'Kansas St' => 'Kansas State Wildcats',
      'Oklahoma St' => 'Oklahoma State Cowboys',
      'Wake Forest' => 'Wake Forest Demon Deacons',
      'Boston College' => 'Boston College Eagles',
      'Fresno St' => 'Fresno State Bulldogs',
      'New Mexico St' => 'New Mexico State Aggies',
      'MTSU' => 'Middle Tennessee Blue Raiders',
      'Iowa' => 'Iowa Hawkeyes',
      'Louisiana Tech' => 'Louisiana Tech Bulldogs',
      'Rice' => 'Rice Owls',
      'NC State' => 'North Carolina State Wolfpack',
      'Florida St' => 'Florida State Seminoles',
      'Cincinnati' => 'Cincinnati Bearcats',
      'Marshall' => 'Marshall Thundering Herd',
      'New Mexico' => 'New Mexico Lobos',
      'Liberty' => 'Liberty Flames',
      'Connecticut' => 'Connecticut Huskies',
      'UCF' => 'UCF Knights',
      'Virginia' => 'Virginia Cavaliers',
      'Notre Dame' => 'Notre Dame Fighting Irish',
      'UNLV' => 'UNLV Rebels',
      'Wyoming' => 'Wyoming Cowboys',
      'Clemson' => 'Clemson Tigers',
      'North Carolina' => 'North Carolina Tar Heels',
      'Mississippi' => 'Mississippi State Bulldogs',
      'Alabama' => 'Alabama Crimson Tide',
      'UCLA' => 'UCLA Bruins',
      'Kent' => 'Kent State Golden Flashes',
      'Arizona' => 'Arizona Wildcats',
      'Arkansas St' => 'Arkansas State Red Wolves',
      'Troy' => 'Troy Trojans',
      'Mississippi St' => 'Mississippi State Bulldogs',
      'Auburn' => 'Auburn Tigers',
      'East Carolina' => 'East Carolina Pirates',
      'Old Dominion' => 'Old Dominion Monarchs',
      'UTEP' => 'UTEP Miners',
      'Southern Miss' => 'Southern Miss Golden Eagles',
      'Georgia Tech' => 'Georgia Tech Yellow Jackets',
      'Georgia' => 'Georgia Bulldogs',
      'Temple' => 'Temple Owls',
      'Towson' => 'Towson Tigers',
      'Florida' => 'Florida Gators',
      'USC' => 'USC Trojans',
      'Miami FL' => 'Miami (FL) Hurricanes',
      'Boise St' => 'Boise State Broncos',
      'Washington' => 'Washington Huskies',
      'BYU' => 'BYU Cougars',
      'Toledo' => 'Toledo Rockets',
      'Hawaii' => 'Hawaii Warriors',
      'Nevada' => 'Nevada Wolf Pack',
      'Nicholls St' => 'Nicholls State Colonels',
      'Texas St' => 'Texas State Bobcats',
      'Washington St' => 'Washington State Cougars',
      'Utah' => 'Utah Utes',
      'Texas A&M' => 'Texas A&M Aggies',
      'Tulane' => 'Tulane Green Wave',
      'E Michigan' => 'Eastern Michigan Eagles',
      'Bowling Green' => 'Bowling Green Falcons',
      'Florida Intl' => 'Florida International Golden Panthers',
      'S Dakota St' => 'South Dakota State Jackrabbits',
      'Wagner' => 'Wagner Seahawks',
      'Morgan St' => 'Morgan State Bears',
      'Robert Morris' => 'Robert Morris Colonials',
      'Florida A&M' => 'Florida A&M Rattlers',
      'Army' => 'Army Black Knights',
      'Tulsa' => 'Tulsa Golden Hurricane',
      'Grambling' => 'Grambling State Tigers',
      'Illinois St' => 'Illinois State Redbirds',
      'Incarnate Word' => 'Incarnate Word Cardinals',
      'Weber St' => 'Weber State Wildcats',
      'James Madison' => 'James Madison Dukes',
      'West Virginia' => 'West Virginia Mountaineers',
      'Texas' => 'Texas Longhorns',
      'Howard' => 'Howard Bison',
      'Houston Bap' => 'Houston Baptist Huskies',
      'Abilene Chr' => 'Abilene Christian Wildcats',
      'Idaho' => 'Idaho Vandals',
      'Norfolk St' => 'Norfolk State Spartans',
      'Colgate' => 'Colgate Raiders',
      'Bucknell' => 'Bucknell Bison',
      'Rhode Island' => 'Rhode Island Rams',
      'Ohio' => 'Ohio State Buckeyes',
      'Portland St' => 'Portland State Vikings',
      'Northern Iowa' => 'Northern Iowa Panthers',
      'Alcorn St' => 'Alcorn State Braves',
      'Indiana St' => 'Indiana State Sycamores',
      'Sam Houston St' => 'Sam Houston State Bearkats',
      'Ball St' => 'Ball State Cardinals',
      'Montana St' => 'Montana State Bobcats',
      'Campbell' => 'Campbell Fighting Camels',
      'LSU' => 'LSU Tigers',
      'Georgia St' => 'Georgia State Panthers',
      'Tennessee' => 'Tennessee Volunteers',
      'Southern Utah' => 'Southern Utah Thunderbirds',
      'UC Davis' => 'UC Davis Aggies',
      'Missouri' => 'Missouri Tigers',
      'Louisville' => 'Louisville Cardinals',
      'Arkansas' => 'Arkansas Razorbacks'
    }
  end
end
