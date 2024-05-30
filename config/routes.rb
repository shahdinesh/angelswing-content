# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      post "users/signup", to: "users#create"
      post "auth/signin", to: "auth#sign_in"

      resources :contents, only: %w[create update destroy]
      get "content", to: "contents#list"
    end
  end
end
