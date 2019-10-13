class ActionGame < ActiveRecord::Base
  validates :external_id, uniqueness: true
  validates :away_team_name, presence: true
  validates :home_team_name, presence: true
end
