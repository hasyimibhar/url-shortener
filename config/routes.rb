Rails.application.routes.draw do
  post '/add', to: 'short_url#add'
end
