Rails.application.routes.draw do
    # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'pages#home'
  
  get 'welcome/index'

  get '/home', to: 'pages#home'
  get '/enter', to: 'pages#enter'
  get '/thanks', to: 'pages#thanks'
  get '/charity', to: 'pages#charity'
  get '/race_report', to: 'pages#race_report_2019'

  # get '/races', to: 'races#index'
  # get '/races/:id', to: 'races#show', as: 'race'
  # get '/races/new', to: 'races#new', as: 'new_race'
  # post '/races', to: 'races#create'
  # get '/races/:id/edit', to: 'races#edit', as: 'edit_race'
  # patch '/races', to: 'races#create'
  # delete 'races/:id', to: 'races#destroy'
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
