Rails.application.routes.draw do

  namespace :admin do
    resources :users
  end

  # removes the users namespace to the sign_in and sign_out actions, and renaming them as login and logout
  devise_for :users, :path => '', :path_names => { sign_in: 'login', 
                                                   sign_out: 'logout', 
                                                   edit: 'account/edit' }

  resources :users, only: [:show, :index, :destroy, :edit, :update]
  resources :users do
    get 'utauloids', on: :member
  end

  get '/account', to: 'users#show'
  get 'my-utauloids', to: 'users#utauloids'

  get '/account/messages/', to:'messages#index', as: "messages"
  get '/account/messages/:id', to: 'messages#show', as: "message"
  get '/account/messages/:id/delete', to: 'messages#add_to_bin', as: "delete_message"

  root to: 'utauloids#index', as: 'root_path'

  resources :utauloids
  resources :categories, only: [:show, :index]
  resources :voicebank_types, only: [:show, :index]
  resources :voice_characteristics, only: [:show, :index]
  resources :voice_languages, only: [:show, :index]

  resources :voice_banks, only: [:edit, :create, :update, :destroy]
  get '/utauloids/:utauloid_id/add-voice-bank', to: 'voice_banks#new'

  post '/favorite_utauloids/:utauloid_id', to: 'favorite_utauloids#create', as: 'add_favorite'
  delete '/favorite_utauloids/:utauloid_id', to: 'favorite_utauloids#destroy', as: 'remove_favorite'

  resources :utauloid_comments, only: [:create]
  resources :difficulty_votes, only: [:create, :update]

  resources :user_links, only: [:create, :update, :destroy]
end