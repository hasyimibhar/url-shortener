require 'rails_helper'

RSpec.describe 'Short URL API', type: :request do
  describe 'POST /add' do
    context 'when the request is valid' do
      before { post '/add', params: { url: 'https://example.com' } }

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the same url is posted twice' do
      before {
        post '/add', params: { url: 'https://someurl.com' }
        @short_url = json['link']['short_url']
      }

      it "shouldn't create new short url" do
        post '/add', params: { url: 'https://someurl.com' }
        expect(response).to have_http_status(200)
        expect(json['link']['short_url']).to eq(@short_url)
      end
    end

    context 'when the url is invalid' do
      before { post '/add', params: { url: 'foobar' } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match('is not a valid HTTP/HTTPS URL')
      end
    end
  end

  describe 'GET /:short' do
    context 'when the url is valid' do
      before {
        post '/add', params: { url: 'https://www.google.com' }
        @short_url = json['link']['short_url']
      }

      it 'redirects to url' do
        get @short_url
        expect(response).to redirect_to('https://www.google.com')
      end
    end

    context 'when the url is invalid' do
      it 'redirects to url' do
        get '/F7aBh4'
        expect(response).to have_http_status(404)
      end
    end
  end
end
