# Get list of NFL teamsrequire 'net/http'
require 'uri'

uri = URI.parse("https://api.actionnetwork.com/mobile/v1/scoreboard/nfl?seasonType=reg&bookIds=15&week=6")
request = Net::HTTP::Get.new(uri)
request["Host"] = "api.actionnetwork.com"
request["Cookie"] = "ajs_anonymous_id=%224694d2b3-6ed3-4ed2-896d-da934f265f5f%22; ajs_group_id=null; ajs_user_id=null; _ga=amp-TMbBb5YnNDw3pbTcxBs_TQ; AN_SESSION_TOKEN_V1=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6InU9NzM1ODI2dD0xNTcwOTQwMTgxNjYxIiwidXNlcl9pZCI6NzM1ODI2LCJleHBlcnRfaWQiOm51bGwsImlzcyI6InNwb3J0c0FjdGlvbiIsImFnZW50IjoiQWN0aW9uLUFwcFN0b3JlLzE2OTEwIENGTmV0d29yay8xMTA3LjEgRGFyd2luLzE5LjAuMCIsImlzUmVzZXRUb2tlbiI6ZmFsc2UsImlzU2Vzc2lvblRva2VuIjpmYWxzZSwic2NvcGUiOltdLCJleHAiOjE2MDI0NzYxODEsImlhdCI6MTU3MDk0MDE4MX0.4MMTq6GOWADSF9qeRaZRXlE78Slwb4vOJdpeTcFglYY"
request["Accept"] = "*/*"
request["User-Agent"] = "Action-AppStore/17086 CFNetwork/1107.1 Darwin/19.0.0"
request["Accept-Language"] = "en-us"
request["Authorization"] = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6InU9NzM1ODI2dD0xNTcwOTQwMTgxNjYxIiwidXNlcl9pZCI6NzM1ODI2LCJleHBlcnRfaWQiOm51bGwsImlzcyI6InNwb3J0c0FjdGlvbiIsImFnZW50IjoiQWN0aW9uLUFwcFN0b3JlLzE2OTEwIENGTmV0d29yay8xMTA3LjEgRGFyd2luLzE5LjAuMCIsImlzUmVzZXRUb2tlbiI6ZmFsc2UsImlzU2Vzc2lvblRva2VuIjpmYWxzZSwic2NvcGUiOltdLCJleHAiOjE2MDI0NzYxODEsImlhdCI6MTU3MDk0MDE4MX0.4MMTq6GOWADSF9qeRaZRXlE78Slwb4vOJdpeTcFglYY"

req_options = {
  use_ssl: uri.scheme == "https",
}

response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
  http.request(request)
end

# response.code
# response.body


# Get list of teams
curl -H 'Host: api.actionnetwork.com' -H 'Cookie: ajs_anonymous_id=%224694d2b3-6ed3-4ed2-896d-da934f265f5f%22; ajs_group_id=null; ajs_user_id=null; _ga=amp-TMbBb5YnNDw3pbTcxBs_TQ; AN_SESSION_TOKEN_V1=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6InU9NzM1ODI2dD0xNTcwOTQwMTgxNjYxIiwidXNlcl9pZCI6NzM1ODI2LCJleHBlcnRfaWQiOm51bGwsImlzcyI6InNwb3J0c0FjdGlvbiIsImFnZW50IjoiQWN0aW9uLUFwcFN0b3JlLzE2OTEwIENGTmV0d29yay8xMTA3LjEgRGFyd2luLzE5LjAuMCIsImlzUmVzZXRUb2tlbiI6ZmFsc2UsImlzU2Vzc2lvblRva2VuIjpmYWxzZSwic2NvcGUiOltdLCJleHAiOjE2MDI0NzYxODEsImlhdCI6MTU3MDk0MDE4MX0.4MMTq6GOWADSF9qeRaZRXlE78Slwb4vOJdpeTcFglYY' -H 'accept: */*' -H 'cache-control: no-cache' -H 'user-agent: Action-AppStore/17086 CFNetwork/1107.1 Darwin/19.0.0' -H 'accept-language: en-us' -H 'authorization: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6InU9NzM1ODI2dD0xNTcwOTQwMTgxNjYxIiwidXNlcl9pZCI6NzM1ODI2LCJleHBlcnRfaWQiOm51bGwsImlzcyI6InNwb3J0c0FjdGlvbiIsImFnZW50IjoiQWN0aW9uLUFwcFN0b3JlLzE2OTEwIENGTmV0d29yay8xMTA3LjEgRGFyd2luLzE5LjAuMCIsImlzUmVzZXRUb2tlbiI6ZmFsc2UsImlzU2Vzc2lvblRva2VuIjpmYWxzZSwic2NvcGUiOltdLCJleHAiOjE2MDI0NzYxODEsImlhdCI6MTU3MDk0MDE4MX0.4MMTq6GOWADSF9qeRaZRXlE78Slwb4vOJdpeTcFglYY' --compressed 'https://api.actionnetwork.com/mobile/v1/scoreboard/ncaaf?bookIds=15&division=FBS'



require 'net/http'
require 'uri'

uri = URI.parse("https://api.actionnetwork.com/mobile/v1/game/69286/edgesummary")
request = Net::HTTP::Get.new(uri)
request["Host"] = "api.actionnetwork.com"
request["Cookie"] = "ajs_anonymous_id=%224694d2b3-6ed3-4ed2-896d-da934f265f5f%22; ajs_group_id=null; ajs_user_id=null; _ga=amp-TMbBb5YnNDw3pbTcxBs_TQ; AN_SESSION_TOKEN_V1=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6InU9NzM1ODI2dD0xNTcwOTQwMTgxNjYxIiwidXNlcl9pZCI6NzM1ODI2LCJleHBlcnRfaWQiOm51bGwsImlzcyI6InNwb3J0c0FjdGlvbiIsImFnZW50IjoiQWN0aW9uLUFwcFN0b3JlLzE2OTEwIENGTmV0d29yay8xMTA3LjEgRGFyd2luLzE5LjAuMCIsImlzUmVzZXRUb2tlbiI6ZmFsc2UsImlzU2Vzc2lvblRva2VuIjpmYWxzZSwic2NvcGUiOltdLCJleHAiOjE2MDI0NzYxODEsImlhdCI6MTU3MDk0MDE4MX0.4MMTq6GOWADSF9qeRaZRXlE78Slwb4vOJdpeTcFglYY"
request["Accept"] = "*/*"
request["User-Agent"] = "Action-AppStore/17086 CFNetwork/1107.1 Darwin/19.0.0"
request["Accept-Language"] = "en-us"
request["Authorization"] = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6InU9NzM1ODI2dD0xNTcwOTQwMTgxNjYxIiwidXNlcl9pZCI6NzM1ODI2LCJleHBlcnRfaWQiOm51bGwsImlzcyI6InNwb3J0c0FjdGlvbiIsImFnZW50IjoiQWN0aW9uLUFwcFN0b3JlLzE2OTEwIENGTmV0d29yay8xMTA3LjEgRGFyd2luLzE5LjAuMCIsImlzUmVzZXRUb2tlbiI6ZmFsc2UsImlzU2Vzc2lvblRva2VuIjpmYWxzZSwic2NvcGUiOltdLCJleHAiOjE2MDI0NzYxODEsImlhdCI6MTU3MDk0MDE4MX0.4MMTq6GOWADSF9qeRaZRXlE78Slwb4vOJdpeTcFglYY"

req_options = {
  use_ssl: uri.scheme == "https",
}

response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
  http.request(request)
end

# response.code
# response.body