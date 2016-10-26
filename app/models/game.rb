# == Schema Information
#
# Table name: games
#
#  id                               :integer          not null, primary key
#  sport                            :string
#  home_team_name                   :string
#  away_team_name                   :string
#  date                             :date
#  home_team_massey_line            :float
#  away_team_massey_line            :float
#  home_team_vegas_line             :float
#  away_team_vegas_line             :float
#  vegas_over_under                 :float
#  massey_over_under                :float
#  created_at                       :datetime         not null
#  updated_at                       :datetime         not null
#  line_diff                        :float
#  over_under_diff                  :float
#  team_to_bet                      :string
#  over_under_pick                  :string
#  home_team_final_score            :integer
#  away_team_final_score            :integer
#  week_id                          :integer
#  home_team_money_percent          :string
#  away_team_money_percent          :string
#  home_team_spread_percent         :string
#  away_team_spread_percent         :string
#  over_percent                     :string
#  under_percent                    :string
#  public_percentage_on_massey_team :integer
#  game_over                        :boolean
#  correct_prediction               :boolean
#

class Game < ActiveRecord::Base
  scope :unplayed,  -> { where.not(home_team_vegas_line: 0.0).where('date >= ?', Date.today-1).order('line_diff DESC').where(sport: 'ncaa_football').where.not(home_team_vegas_line: nil).where.not(vegas_over_under: nil) }
  scope :played,    -> { where.not(home_team_vegas_line: 0.0).where('date < ?', Date.today).order('line_diff DESC').where(sport: 'ncaa_football').where.not(home_team_vegas_line: nil).where.not(vegas_over_under: nil) }
  scope :best_bets, -> { where.not(home_team_vegas_line: 0.0).order('line_diff DESC').where('line_diff > ?', 3).where('public_percentage_on_massey_team < ?', 35).where.not(public_percentage_on_massey_team: nil) }

  def self.calculate_picks
    Game.all.each do |game|
      game.update(
        line_diff: (game.home_team_massey_line - game.home_team_vegas_line).abs,
        over_under_diff: game.massey_over_under - game.vegas_over_under,
        team_to_bet: self.find_team_to_bet(game),
        over_under_pick: self.pick_over_under(game),
        public_percentage_on_massey_team: self.get_public_percentage_on_massey_team(game)
      ) unless game.home_team_vegas_line.nil? || game.massey_over_under.nil? || game.vegas_over_under.nil?
    end
  end

  def self.pick_over_under(game)
    if game.massey_over_under - game.vegas_over_under > 0
      "Over"
    else
      "Under"
    end
  end

  def strength
    return (line_diff * 100 / public_percentage_on_massey_team).round(2) unless public_percentage_on_massey_team.nil?
    0
  end

  def self.get_public_percentage_on_massey_team(game)
    return game.home_team_spread_percent if game.team_to_bet == game.home_team_name
    return game.away_team_spread_percent if game.team_to_bet == game.away_team_name
  end

  def self.find_team_to_bet(game)
    if game.home_team_massey_line - game.home_team_vegas_line > 0
      game.away_team_name
    else
      game.home_team_name
    end
  end

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
    actual_line = away_team_final_score - home_team_final_score
    home_team_vegas_line > actual_line
  end

  def correct_away_prediction
    actual_line = home_team_final_score - away_team_final_score
    away_team_vegas_line > actual_line
  end

  def game_over?
    return true if Time.zone.today > date
    false
  end

  def self.was_i_right?
    Game.where(game_over: true).each do |game|
      if game.correct_line_prediction?
        game.correct_prediction = true
        game.save
      else
        game.correct_prediction = false
        game.save
      end
    end
  end

  def team_to_bet_line
    if team_to_bet_home_or_away? == "away"
      away_team_vegas_line
    else
      home_team_vegas_line
    end
  end

end
