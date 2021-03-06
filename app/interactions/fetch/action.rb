class Fetch::Action < Less::Interaction
  expects :sport
  expects :week, allow_nil: true
  expects :get_league_info, allow_nil: true

  def run
    url = construct_url
    response = action_api_request(url)
    return league_info(response) if get_league_info
    @week = week || response['league']['current_week']
    fetch_and_save_action_data(response['games']) if response['games']
  end

  private

  def action_api_request(url)
    Common::FetchJSON.run(
      url: url, auth_token: Rails.application.credentials.action_sports_token
    )
  end

  def construct_url(game_id = nil)
    if game_id
      return(
        "https://api.actionnetwork.com/mobile/v1/game/#{game_id}/edgesummary"
      )
    end

    url =
      "https://api.actionnetwork.com/web/v1/sharpreport/#{
        format_sport
      }bookIds=15"

    url += "&week=#{week}" if week
    puts 'Actionsports URL:' + url unless Rails.env.test?
    url
  end

  def format_sport
    case sport
    when 'ncaaf'
      'ncaaf?'
      # 'ncaaf?division=FBS'
    when 'cb'
      # 'ncaab?division=D1'
      'ncaab?'
    else
      sport + '?'
    end
  end

  def league_info(response)
    response['league']
  end

  def fetch_and_save_action_data(games)
    games.each do |game|
      next unless game['odds']
      edge_data = fetch_edge_summary(game['id'])
      game_hash = set_game_hash(game, edge_data)
      save_game(game_hash)
    end
  end

  def fetch_edge_summary(game_id)
    url = construct_url(game_id)
    action_api_request(url)
  end

  def set_game_hash(game, edge_data = nil)
    {
      away_team_name: team_name(game, 'away'),
      away_team_ats_percent: ats_percent(game, 'away'),
      away_team_ml_percent: ml_percent(game, 'away'),
      over_percent: total_percent(game, 'over'),
      home_team_name: team_name(game, 'home'),
      home_team_ats_percent: ats_percent(game, 'home'),
      home_team_ml_percent: ml_percent(game, 'home'),
      under_percent: total_percent(game, 'under'),
      home_team_vegas_line: vegas_line(game, 'home'),
      away_team_vegas_line: vegas_line(game, 'away'),
      vegas_over_under: odds_for_game(game)['total'],
      sport: sport,
      start_time: game['start_time'],
      game_date: Date.parse(game['start_time']),
      external_id: game['id'],
      away_team_final_score: final_score(game, 'away'),
      game_over: game_over(game),
      home_team_final_score: final_score(game, 'home'),
      num_bets: num_bets(game),
      home_contrarian: value_stats(game, 'home', 'Contrarian'),
      away_contrarian: value_stats(game, 'away', 'Contrarian'),
      home_rlm: value_stats(game, 'home', 'Rlm'),
      away_rlm: value_stats(game, 'away', 'Rlm'),
      away_steam: value_stats(game, 'away', 'Steam'),
      home_steam: value_stats(game, 'home', 'Steam'),
      home_overall_rating: value_stats(game, 'home', 'Overall'),
      away_overall_rating: value_stats(game, 'away', 'Overall'),
      home_team_logo: team_logo(game, 'home'),
      away_team_logo: team_logo(game, 'away'),
      home_team_abbr: team_abbr(game, 'home'),
      away_team_abbr: team_abbr(game, 'away'),
      edge_data: edge_data,
      week: @week
    }
  end

  def save_game(game_hash)
    game =
      ActionGame.where(external_id: game_hash[:external_id]).first_or_create
    game.update(game_hash)
  end

  def value_stats(game, home_or_away, action_stat)
    home_or_away_stats =
      game["#{home_or_away}_sharpreport"] ||
        (
          if game['value_stats']
            game['value_stats'][0]["#{home_or_away}_value_breakdown"]
          end
        )
    return 0 unless home_or_away_stats
    action_stat =
      home_or_away_stats.select { |hash| hash.value?(action_stat) }
    action_stat.present? ? action_stat.first['value'] : 0
  end

  def game_over(game)
    game['status'] == 'complete'
  end

  def team_name(game, home_or_away)
    team_id = game["#{home_or_away}_team_id"]
    team = game['teams'].select { |team| team['id'] == team_id }
    team.first['full_name']
  end

  def team_logo(game, home_or_away)
    team_id = game["#{home_or_away}_team_id"]
    team = game['teams'].select { |team| team['id'] == team_id }
    team.first['logo']
  end

  def team_abbr(game, home_or_away)
    team_id = game["#{home_or_away}_team_id"]
    team = game['teams'].select { |team| team['id'] == team_id }
    team.first['abbr']
  end

  def odds_for_game(game)
    game['odds'].select { |odds| odds['type'] == 'game' }.first
  end

  def ats_percent(game, home_or_away)
    odds_for_game(game)["spread_#{home_or_away}_public"]
  end

  def ml_percent(game, home_or_away)
    odds_for_game(game)["ml_#{home_or_away}_public"]
  end

  def total_percent(game, over_or_under)
    odds_for_game(game)["total_#{over_or_under}_public"]
  end

  def vegas_line(game, home_or_away)
    odds_for_game(game)["spread_#{home_or_away}"]
  end

  def final_score(game, home_or_away)
    game_over(game) ? game['boxscore']["total_#{home_or_away}_points"] : nil
  end

  def num_bets(game)
    odds_for_game(game)['num_bets']
  end
end
