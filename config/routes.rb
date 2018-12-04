Rails.application.routes.draw do
  post '/add', to: 'short_url#add'

  # TODO: don't hardcode the length of short url
  get '/:short', to: 'short_url#redirect', constraints: { short: /[a-zA-Z0-9]{6}/ }
end
