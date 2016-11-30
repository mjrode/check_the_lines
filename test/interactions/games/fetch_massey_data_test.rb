require 'test_helper'

class Games::FetchMasseyDataTest < ActiveSupport::TestCase
  test 'fetches NCAAB data from MasseyRatings for current month' do
		VCR.use_cassette("ncaam_basketball") do
		  Games::FetchMasseyData.run(url: "http://www.masseyratings.com/cb/11590/games?dt=20161111", sport: "ncaa_basketball")
			game = Game.find_by_home_team_name("Auburn")

			assert game.away_team_name == "North Florida"
			assert game.home_team_massey_line == -6.5
			assert game.away_team_massey_line == 6.5
			assert game.week_id == 20161111
		end
  end

  test 'fetchs NCAAF data from MasseyRatings for previous month' do
		VCR.use_cassette("ncaam_football_past_month") do
		  Games::FetchMasseyData.run(url: "http://www.masseyratings.com/cf/11604/games?dt=20160917", sport: "ncaa_football", sportsbook_month: "September", date: "17")
			game = Game.find_by_home_team_name("Rice")

			assert game.away_team_name == "Baylor"
			assert game.home_team_massey_line == 26.5
			assert game.away_team_massey_line == -26.5
			assert game.week_id == 20160917
		end
  end
end
