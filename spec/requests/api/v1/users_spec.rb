require 'swagger_helper'

RSpec.describe 'api/v1/users', type: :request, swagger: true do

  # GET /api/v1/users - Lister les utilisateurs
  path '/api/v1/users' do
    get('list users') do
      tags 'Users'
      produces 'application/json'
      response(200, 'successful') do
        schema type: :array, items: { 
          type: :object,
          properties: {
            id: { type: :integer },
            name: { type: :string },
            surname: { type: :string },
            email: { type: :string },
            profession: { type: :string },
            city: { type: :string },
            country: { type: :string }
          }
        }
        run_test!
      end
    end
  end

  # POST /api/v1/users - Créer un utilisateur
  path '/api/v1/users' do
    post('create user') do
      tags 'Users'
      consumes 'application/json'
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          surname: { type: :string },
          email: { type: :string },
          password: { type: :string },
          password_confirmation: { type: :string },
          profession: { type: :string },
          city: { type: :string },
          country: { type: :string }
        },
        required: ['name', 'surname', 'email', 'password', 'password_confirmation']
      }
      response(201, 'created') do
        let(:user) { 
          { 
            name: 'John', surname: 'Doe', email: 'john@example.com', 
            password: 'password123', password_confirmation: 'password123', 
            profession: 'Developer', city: 'New York', country: 'USA' 
          } 
        }
        run_test!
      end
      response(422, 'unprocessable entity') do
        let(:user) { { name: nil, surname: nil, email: nil, password: nil, password_confirmation: nil } }
        run_test!
      end
    end
  end

  # GET /api/v1/users/{id} - Récupérer un utilisateur par ID
  path '/api/v1/users/{id}' do
    get('show user') do
      tags 'Users'
      produces 'application/json'
      parameter name: :id, in: :path, type: :integer, description: 'ID de l\'utilisateur'
      response(200, 'successful') do
        schema type: :object, properties: {
          id: { type: :integer },
          name: { type: :string },
          surname: { type: :string },
          email: { type: :string },
          profession: { type: :string },
          city: { type: :string },
          country: { type: :string }
        }
        run_test!
      end
      response(404, 'not found') do
        let(:id) { 'invalid' }
        run_test!
      end
    end
  end

  # PUT /api/v1/users/{id} - Mettre à jour un utilisateur
  path '/api/v1/users/{id}' do
    put('update user') do
      tags 'Users'
      consumes 'application/json'
      parameter name: :id, in: :path, type: :integer, description: 'ID de l\'utilisateur'
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          surname: { type: :string },
          email: { type: :string },
          profession: { type: :string },
          city: { type: :string },
          country: { type: :string }
        }
      }
      response(200, 'successful') do
        let(:id) { 1 }
        let(:user) { { name: 'Updated', surname: 'User', email: 'updated@example.com' } }
        run_test!
      end
      response(404, 'not found') do
        let(:id) { 'invalid' }
        run_test!
      end
    end
  end

  # DELETE /api/v1/users/{id} - Supprimer un utilisateur
  path '/api/v1/users/{id}' do
    delete('delete user') do
      tags 'Users'
      parameter name: :id, in: :path, type: :integer, description: 'ID de l\'utilisateur'
      response(204, 'no content') do
        let(:id) { 1 }
        run_test!
      end
      response(404, 'not found') do
        let(:id) { 'invalid' }
        run_test!
      end
    end
  end
end
