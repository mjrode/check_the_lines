# == Schema Information
#
# Table name: games
#
#  id                    :integer          not null, primary key
#  sport                 :string
#  home_team_name        :string
#  away_team_name        :string
#  date                  :date
#  home_team_massey_line :float
#  away_team_massey_line :float
#  home_team_vegas_line  :float
#  away_team_vegas_line  :float
#  vegas_over_under      :float
#  massey_over_under     :float
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  line_diff             :float
#

class Game < ActiveRecord::Base
end
