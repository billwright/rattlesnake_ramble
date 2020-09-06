Rails.application.routes.draw do
  root 'pages#home'
  
  get 'welcome/index'

  get '/home', to: 'pages#home'
  get '/enter', to: 'pages#enter'
  get '/thanks', to: 'pages#thanks'
  get '/charity', to: 'pages#charity'
  get '/race_report', to: 'pages#race_report_2019'

  devise_for :users

  resources :races
  resources :racers
  
  resources :race_editions, except: :index do
    member do
      get 'enter'
      post 'create_entry'
      get 'racer_emails'
      get 'racer_info_csv'
    end
  end
  
  resources :race_entries do
    member do
      get 'successful_entry'  
      get 'cancelled_payment'
    end
  end
  
  resources :products
end
