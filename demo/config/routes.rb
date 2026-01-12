# frozen_string_literal: true

Rails.application.routes.draw do
  mount Lookbook::Engine, at: '/lookbook'

  get 'up' => 'rails/health#show', :as => :rails_health_check

  root to: redirect('/lookbook')
end
