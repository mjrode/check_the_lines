class Games::FetchHtml < Less::Interaction
	expects :url
	expects :sport, allow_nil: true
	expects :date, allow_nil: true
  expects :last_month, allow_nil: true

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
    change_date(browser) unless date.nil?
	end

	def change_date(browser)
    browser.link(:text =>"Change Date").click
  	browser.link(:title => "Prev").click  if last_month
    browser.link(:text =>date).click
  end
end
