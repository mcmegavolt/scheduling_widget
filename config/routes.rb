# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  root 'services#index'

  resources :services, only: :index do
    resources :locations, only: :index
  end
end
