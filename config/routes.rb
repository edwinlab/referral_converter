Rails.application.routes.draw do
  root 'dashboard#index'

  get '/ajax/folders', to: 'ajax#folders'
  get '/ajax/converts', to: 'ajax#converts'
  post '/ajax/renders', to: 'ajax#renders'
end
