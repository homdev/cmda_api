require 'rails_helper'

RSpec.describe 'API::V1::Users', type: :request do
  describe 'POST /api/v1/users' do
    it 'creates a user' do
      post '/api/v1/users', params: { 
        user: { 
          name: 'John', surname: 'Doe', email: 'john@example.com', 
          password: 'password123', password_confirmation: 'password123', 
          profession: 'Developer', city: 'New York', country: 'USA' 
        } 
      }

      expect(response).to have_http_status(:created)
    end

    it 'returns unprocessable entity when missing required fields' do
      post '/api/v1/users', params: { 
        user: { name: nil, surname: nil, email: nil, password: nil, password_confirmation: nil } 
      }

      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end
