# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, only: :omniauth_callbacks, controllers: { omniauth_callbacks: 'omniauth_callbacks' }
  mount ShoppingCart::Engine => '/', as: :cart_engine
  scope '(:locale)', locale: Regexp.new(I18n.available_locales.join('|')) do
    root to: 'home#index'
    resources :books, only: %i[index show]
    resources :books do
      resources :reviews, only: [:create]
    end
    devise_for :users, skip: :omniauth_callbacks, controllers: { registrations: 'registrations' }
    ActiveAdmin.routes(self)
  end
end
