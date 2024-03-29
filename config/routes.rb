Rails.application.routes.draw do
  root 'pages#home'
  
  get 'welcome/index'

  get '/home', to: 'pages#home'
  get '/thanks', to: 'pages#thanks'
  get '/charity', to: 'pages#charity'
  get '/race_reports', to: 'pages#race_reports'

  devise_for :users

  resources :races
  resources :racers
  
  resources :race_editions do
    member do
      get 'enter'
      post 'create_entry'
      get 'racer_emails'
      get 'racer_info_csv'
      get 'race_entries'
    end
  end
  
  resources :race_entries, except: [:index, :show, :new, :create] do
    member do
      get 'successful_entry'  
      get 'cancelled_payment'
    end
  end
  
  resources :products
end
