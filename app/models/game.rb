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
#  week_id               :integer
#

class Game < ActiveRecord::Base
  scope :unplayed, ->  { where('date >= ?', Date.today).order('line_diff DESC').where(sport: 'ncaa_football').where.not(home_team_vegas_line: -0.0).where.not(home_team_vegas_line: 0.0) }

  def correct_over_under_prediction?
    total = away_team_final_score + home_team_final_score
    if over_under_pick == 'Over' && total > vegas_over_under
      true
    elsif over_under_pick == 'Under' && total < vegas_over_under
      true
    else
      false
    end
  end

  def correct_line_prediction?
    return correct_home_prediction if team_to_bet_home_or_away? == "home"
    correct_away_prediction if team_to_bet_home_or_away? == "away"
  end

  def team_to_bet_home_or_away?
    name = team_to_bet
    return "away" if name == away_team_name
    "home" if name == home_team_name
  end

  def correct_home_prediction
    actual_line = home_team_final_score - away_team_final_score
    actual_line >= home_team_vegas_line.abs
  end

  def correct_away_prediction
    actual_line = away_team_final_score - home_team_final_score
    actual_line >= away_team_vegas_line.abs
  end

  def game_over?
    return true if Time.zone.today > date
    false
  end
end
