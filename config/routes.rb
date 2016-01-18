Rails.application.routes.draw do

  namespace :admin do
    resources :users
  end

  # removes the users namespace to the sign_in and sign_out actions, and renaming them as login and logout
  devise_for :users, :path => '', :path_names => { sign_in: 'login', 
                                                   sign_out: 'logout', 
                                                   edit: 'account/edit' }

  resources :users, only: [:show, :index, :destroy, :edit, :update]

  root to: 'utauloids#index', as: 'root_path'

  resources :utauloids
  resources :categories, only: [:show, :index]
  resources :voicebank_types, only: [:show, :index]
  resources :voice_characteristics, only: [:show, :index]
  resources :voice_languages, only: [:show, :index]

  resources :favorite_utauloids, only: [:create, :destroy]
  resources :utauloid_comments, only: [:create]
  resources :difficulty_votes, only: [:create, :update]

  resources :user_links, only: [:create, :update, :destroy]
end