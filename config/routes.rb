Rails.application.routes.draw do

  post '/events' => 'events#record'
end
