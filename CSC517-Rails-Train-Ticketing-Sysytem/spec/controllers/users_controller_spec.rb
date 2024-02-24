# spec/controllers/users_controller_spec.rb

require 'rails_helper'

RSpec.describe UsersController, type: :controller do
    #user = User.create(email_address: 'example@example.com', password: 'password')
    

    before do
        user = User.create(id:1)
        #allow(controller).to receive(:authorized)
        #allow(controller).to receive(:set_user)
        session[:user_id] = user.id
    end

    describe 'GET #index' do
        it 'returns a success response: get a list of all users' do
            get :index
            expect(response).to be_successful
        end
    end

    describe 'GET #show' do
        it 'returns a success response: get the info of a user' do
            user = User.create(id:1)
            get :show, params: {id: user.id}
            expect(response).to be_successful
        end
    end

  describe 'GET #new' do
    it 'returns a success response: go to the sign up page' do
      get :new
      expect(response).to be_successful
    end
  end

  describe 'GET #edit' do
    it 'returns a success response: go to the edit page' do
        user = User.create(id:1)
        get :edit, params: { id: user.id }
        expect(response).to be_successful
    end
  end
  
  # -----------------------------------------------------------------
  describe 'POST #create' do
    context 'with valid parameters' do
      let(:valid_params) do
        {
          user: {
            name: 'John Doe',
            email_address: 'john@example.com',
            password: 'password123',
            address: '123 Main St',
            phone_number: '555-555-5555',
            credit_number: '1234567890'
          }
        }
      end

      it 'creates a new user' do
        expect {
          post :create, params: valid_params
        }.to change(User, :count).by(1)
      end

      it 'redirects to the root path' do
        post :create, params: valid_params
        expect(response).to redirect_to(root_path)
      end

      it 'sets a success notice' do
        post :create, params: valid_params
        expect(flash[:notice]).to eq('User was successfully created.')
      end
    end

    context 'with invalid parameters' do
      let(:invalid_params) do
        {
          user: {
            name: '', # Invalid: Name is required
            email_address: 'invalid_email', # Invalid: Invalid email format
            password: 'short', # Invalid: Password is too short
            address: '123 Main St',
            phone_number: '555-555-5555',
            credit_number: '1234567890123456'
          }
        }
      end

      it 'does not create a new user' do
        expect {
          post :create, params: invalid_params
        }.to_not change(User, :count)
      end

      it 'sets an error status' do
        post :create, params: invalid_params
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  # -----------------------------------------------------------------

  describe 'PATCH #update' do
    context 'with valid parameters' do

        let(:update_params) do
            {
                id: '1',
                user: {
                name: 'Updated Name',
                email_address: 'updated@example.com',
                address: 'Updated Address',
                phone_number: '111-111-1111',
                credit_number: '888777666'
              }
            }
        end
        
        
      it 'updates the user' do 
        #id = '2'
        #get :edit, params:{id: id}
        patch :edit, params: update_params
        expect(response).to be_successful
      end
    end
  end

  # -----------------------------------------------------------------
  # -----------------------------------------------------------------

  describe 'DELETE #destroy' do
    it 'destroys the requested user' do
      user = User.new(id:1)
      expect {
        delete :destroy, params: { id: user.id }
      }.to change(User, :count).by(-1)
    end

    
  end
end
