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
#  date                  :date
#  external_id           :integer
#  sport                 :string
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#

require 'test_helper'

class MasseyGameTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
