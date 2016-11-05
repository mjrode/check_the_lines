require 'test_helper'

class Games::FetchHtml < ActiveSupport::TestCase
	test 'Gets NCAA football data when passed a url, sport' do
		Games::FetchHtml.run(url: "http://www.masseyratings.com/pred.php?s=cf&sub=11604", sport: "ncaa_football")
  end
end
