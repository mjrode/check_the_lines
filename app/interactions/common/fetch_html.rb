class Games::FetchHtml < Less::Interaction
  expects :url

  def run
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
