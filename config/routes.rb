require 'resque/server'
FavoriteColors::Application.routes.draw do
  root :to => 'surveys#new', :via => :get
  resources :surveys, :path => ''
  match '/:id' => 'surveys#show', :via => :get
  match '/:id' => 'surveys#update', :via => :post
  mount Resque::Server.new, :at => "/resque"
end
