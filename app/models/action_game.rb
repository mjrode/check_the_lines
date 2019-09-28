# == Schema Information
#
# Table name: action_games
#
#  id                    :integer          not null, primary key
#  game_date             :date
#  sport                 :string
#  home_team_name        :string
#  away_team_name        :string
#  under_percent         :integer
#  over_percent          :integer
#  home_team_ml_percent  :integer
#  away_team_ml_percent  :integer
#  home_team_ats_percent :integer
#  away_team_ats_percent :integer
#  away_team_vegas_line  :float
#  home_team_vegas_line  :float
#  vegas_over_under      :float
#  home_team_final_score :float
#  away_team_final_score :float
#  game_time             :datetime
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  external_id           :integer
#  processed             :boolean          default(FALSE)
#  game_over             :boolean
#

class ActionGame < ActiveRecord::Base
  validates :home_team_ml_percent, presence: true
  validates :away_team_ml_percent, presence: true
  validates :home_team_ats_percent, presence: true
  validates :away_team_ats_percent, presence: true
  validates :away_team_name, presence: true
  validates :home_team_name, presence: true
  # validates :external_id, uniqueness: true
end
