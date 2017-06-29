# == Schema Information
#
# Table name: massey_games
#
#  id                    :integer          not null, primary key
#  home_team_massey_line :float
#  away_team_massey_line :float
#  away_team_name        :string
#  home_team_name        :string
#  massey_over_under     :float
#  home_team_vegas_line  :float
#  away_team_vegas_line  :float
#  game_date             :date
#  external_id           :integer
#  sport                 :string
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  processed             :boolean          default(FALSE)
#  game_over             :boolean          default(FALSE)
#

class MasseyGame < ActiveRecord::Base
  validates :home_team_massey_line, presence: true
  validates :away_team_massey_line, presence: true
  validates :away_team_name, presence: true
  validates :home_team_name, presence: true

end
