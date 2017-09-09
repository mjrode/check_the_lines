class Games::FetchHtml < Less::Interaction
  expects :url

  def run
    Selenium::WebDriver::PhantomJS.path ='/Users/mike.rode/Malauzai/projects/phantomjs-2.1.1-macosx/bin/phantomjs' if Rails.env = 'development'
    begin
      fetch_page
    rescue
      fetch_page
    end
  end

  private

  def fetch_page
    browser = Watir::Browser.new :phantomjs
    browser.goto url
    doc = Nokogiri::HTML(browser.html)
    browser.close
    doc
  end

end
