# frozen_string_literal: true

Rails.application.routes.draw do
  resources :organizations
  root to: 'organizations#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
