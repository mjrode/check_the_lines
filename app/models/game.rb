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
#  over_under_diff       :float
#  team_to_bet           :string
#  over_under_pick       :string
#  home_team_final_score :integer
#  away_team_final_score :integer
#

class Game < ActiveRecord::Base

  def self.inprogress?(game)
    if game.home_team_final_score.zero? && game.away_team_final_score.zero?
      true
    else
      false
    end
  end

  def actual_line(game)

  end

  def self.correct_prediction?(game)
    if game.team_to_bet == game.home_team_name
      vegas_line  = game.home_team_vegas_line
      actual_line = game.away_team_final_score - game.home_team_final_score
    else
      vegas_line  = game.home_team_vegas_line
      actual_line = game.home_team_final_score - game.away_team_final_score
    end

    if actual_line > vegas_line
      false
    else
      true
    end
  end

  def self.game_over?(game)
    return true if Date.today > game.date
    false
  end
end
