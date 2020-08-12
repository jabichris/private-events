require 'rails_helper'

RSpec.describe 'Welcomes', type: :request do
  describe 'GET /show' do
    it 'returns http success' do
      get '/welcome/show'
      expect(response).to have_http_status(:success)
    end
  end
end
