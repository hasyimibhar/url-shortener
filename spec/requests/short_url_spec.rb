require 'rails_helper'

RSpec.describe 'Short URL API', type: :request do
  describe 'POST /add' do
    # valid payload
    let(:valid_attributes) { { url: 'https://example.com' } }

    context 'when the request is valid' do
      before { post '/add', params: valid_attributes }

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
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
end
