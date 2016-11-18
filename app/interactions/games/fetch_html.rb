class Games::FetchHtml < Less::Interaction
	 expects :sportsbook_month, allow_nil: true
	 expects :url
	 expects :sport, allow_nil: true
	 expects :date, allow_nil: true

	 def run
     browser = Watir::Browser.new :phantomjs
     navigate_to_page(browser)
     doc = Nokogiri::HTML(browser.html)
     browser.close
     doc
	 end

	 private

	 def navigate_to_page(browser)
	 	 browser.goto base_url
	   select_pregame_page(browser) if url.include?("pregame")
	 end

	 def base_url
	 	 return url unless url.nil?
	 end

	 def select_pregame_page(browser)
	 	 browser.link(:text =>"NBA").when_present.click if sport == "nba"
	   browser.link(:text =>"CFB").when_present.click if sport == "ncaa_football"
		 browser.link(:text =>"CBB").when_present.click if sport == "ncaa_basketball"
     change_date(browser) unless date.nil?
	 end

  def change_date(browser)
	  browser.link(:text =>"Change Date").click
	  months_back.times{browser.link(:title => "Prev").click}
    browser.link(:text =>date).click
  end

	 def months_back
		 return 0 if sportsbook_month.nil?
     Date::MonthDiff.run(month: sportsbook_month)
	 end
end
