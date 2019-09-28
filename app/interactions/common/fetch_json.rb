# http://www.masseyratings.com/predjson.php?s=mlb&sub=14342&dt=20170626
class Common::FetchJSON < Less::Interaction
  expects :url
  expects :auth_token, allow_nil: true

  def run
    fetch_json
  end

  private

  def fetch_json
    authorized = HTTP.auth(auth_token) if auth_token
    response = auth_token ? authorized.get(url) : HTTP.get(url)
    JSON.parse(response)
  end
end
