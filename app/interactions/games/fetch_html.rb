class Games::FetchHtml < Less::Interaction
  expects :url

  def run
    browser = Watir::Browser.new :phantomjs
    browser.goto url
    doc = Nokogiri::HTML(browser.html)
    browser.close
    doc
  end
end
