class PagesController < ApplicationController
  def home; end

  def about; end

  def admin; end

  def fetch_data
    Jobs::FetchTodaysData.run
    redirect_to best_bets_games_path
  end
end
