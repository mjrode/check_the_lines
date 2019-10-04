class Common::FetchHtml < Less::Interaction
  require 'open-uri'
  expects :url

  def run
    fetch_page
  end

  private

  def fetch_page
    uri = URI.parse(url)
    puts "URI for request #{uri}"
    Nokogiri::HTML(uri.open)
  end
end
