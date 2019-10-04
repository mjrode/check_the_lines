class Common::FetchHtml < Less::Interaction
  require 'open-uri'
  expects :url

  def run
    fetch_page
  end

  private

  def fetch_page
    uri = URI.parse(url)
    Nokogiri::HTML(uri.open)
  rescue => e
    puts e
  end
end
