Rails.application.routes.draw do
  root 'dashboard#index'

  get '/ajax/folders', to: 'ajax#folders'
end
