class ShortUrlController < ApplicationController
  def add
    # Search if url has been submitted before.
    # If yes, no need to generate a new short url.
    short_url = ShortUrl.find_by value: params[:url]

    if short_url.nil?
      short_url = ShortUrl.generate(params[:url])
      short_url.valid?

      status = :ok
      errors = {}

      if !short_url.valid?
        # Rename value to url
        errors[:url] = short_url.errors[:value]

        response = { errors: errors }
        status = :unprocessable_entity
      else
        short_url.save!

        response = {
          link: {
            url: short_url.value,
            short_url: short_url.short_url(Rails.configuration.app_url)
          },
          errors: errors
        }
      end
    else
      response = {
        link: {
          url: short_url.value,
          short_url: short_url.short_url(Rails.configuration.app_url)
        },
        errors: {}
      }
    end

    render json: response, status: status
  end

  def redirect
    short_url = ShortUrl.find_by short: params[:short]
    if short_url.nil?
      render status: :not_found
    else
      render status: :found, location: short_url.value
    end
  end
end
