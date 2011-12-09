require 'resque/server'
FavoriteColors::Application.routes.draw do
  resources :surveys
  mount Resque::Server.new, :at => "/resque"
end
