Rails.application.routes.draw do
  resources :games do
    collection do
      get 'ncaaf'
      get 'refresh'
      get 'about'
      get 'best_bets'
      get 'nfl'
    end
  end

  resources :admin do
    collection { get 'refresh' }
  end

  root 'games#home'
end
