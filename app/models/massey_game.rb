class MasseyGame < ActiveRecord::Base
  validates :home_team_massey_line, presence: true
  validates :away_team_massey_line, presence: true
  validates :away_team_name, presence: true
  validates :home_team_name, presence: true
  validates :external_id, uniqueness: true

  scope :unprocessed, -> { where(processed: false) }
end
