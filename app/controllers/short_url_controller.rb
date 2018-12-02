class ShortUrlController < ApplicationController
  def add
    short_url = ShortUrl.generate(params[:url])
    short_url.valid?

    response = {}
    status = :ok
    errors = {}

    if !short_url.valid?
      # Rename value to url
      errors[:url] = short_url.errors[:value]

      response = {
        errors: errors
      }

      status = :unprocessable_entity
    else
      response = {
        link: {
          url: short_url.value,
          short_url: short_url.short_url(Rails.configuration.app_url)
        },
        errors: errors
      }
    end

    render json: response, status: status
  end
end
