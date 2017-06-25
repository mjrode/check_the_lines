# http://www.masseyratings.com/predjson.php?s=mlb&sub=14342&dt=20170626
class Common::FetchJSON < Less::Interaction
  expects :url

  def run
    fetch_json(url)
  end

  private

  def fetch_json(url)
    response = HTTP.get(url)
    JSON.parse(response)
  end
end
