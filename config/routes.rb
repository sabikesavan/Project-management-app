# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  resources :users
  resources :projects
  resources :userprojects
  resources :tasks
  resources :comments
  get '/cancel/:id', to: 'userprojects#cancel', as: :cancel
  # get '/index', to: 'searches#index', as: 'index'
  get '/search', to: 'userprojects#search', as: 'search'
  root 'users#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
