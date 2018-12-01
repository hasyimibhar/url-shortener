class ShortUrlController < ApplicationController
  def add
    short_url = ShortUrl.generate(params[:url])
    response = {
      link: {
        url: short_url.value,
        short_url: short_url.short_url(Rails.configuration.app_url)
      },
      errors: []
    }

    render json: response, status: :ok
  end
end
