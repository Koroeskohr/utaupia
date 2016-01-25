Rails.application.routes.draw do

  ActiveAdmin.routes(self)

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

  get '/account/messages', to: 'messages#index', as: 'messages'
  post '/account/messages/delete', to: 'messages#add_multiple_to_bin', as: 'delete_messages'
  get '/account/messages/:id', to: 'messages#show', as: 'message'
  get '/account/messages/:id/delete', to: 'messages#add_to_bin', as: 'delete_message'
  get '/account/messages/:id/mark_as_seen', to: 'messages#mark_as_seen', as: 'mark_as_seen_message'
  get '/account/messages/:id/mark_as_not_seen', to: 'messages#mark_as_not_seen', as: 'mark_as_not_seen_message'

  post '/account/user_links/create', to: 'user_links#create', as: 'user_links'
  match '/account/user_links/:id', to: 'user_links#update', as: 'user_link', via: [:patch, :put, :delete]

  root to: 'homepage#index', as: 'root_path'

  resources :utauloids do
    get 'report', on: :member
  end

  resources :categories, only: [:show, :index]
  resources :voicebank_types, only: [:show, :index]
  resources :voice_characteristics, only: [:show, :index]
  resources :voice_languages, only: [:show, :index]

  resources :voice_banks, only: [:edit, :create, :update, :destroy]
  get '/utauloids/:utauloid_id/add-voice-bank', to: 'voice_banks#new', as: 'new_voice_bank'

  post '/favorite_utauloids/:utauloid_id', to: 'favorite_utauloids#create', as: 'add_favorite'
  delete '/favorite_utauloids/:utauloid_id', to: 'favorite_utauloids#destroy', as: 'remove_favorite'

  resources :utauloid_comments, only: [:create, :edit, :update]
  resources :difficulty_votes, only: [:create, :update]

end