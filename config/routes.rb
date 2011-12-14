require 'resque/server'
FavoriteColors::Application.routes.draw do
  root :to => 'surveys#new'
  resources :surveys, :path => ''
  mount Resque::Server.new, :at => "/resque"
end
