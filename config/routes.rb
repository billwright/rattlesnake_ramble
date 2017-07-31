Rails.application.routes.draw do
    # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'pages#home'
  
  get 'welcome/index'

  get '/home', to: 'pages#home'
  get '/enter', to: 'pages#enter'
  
  # get '/races', to: 'races#index'
  # get '/races/:id', to: 'races#show', as: 'race'
  # get '/races/new', to: 'races#new', as: 'new_race'
  # post '/races', to: 'races#create'
  # get '/races/:id/edit', to: 'races#edit', as: 'edit_race'
  # patch '/races', to: 'races#create'
  # delete 'races/:id', to: 'races#destroy'
  resources :races
  resources :racers
  resources :race_editions
  resources :race_entries
  resources :products

end
