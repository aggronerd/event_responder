Rails.application.routes.draw do

  post '/events' => 'events#record'
  get '/events' => 'events#summary'
  root 'events#summary'

end
