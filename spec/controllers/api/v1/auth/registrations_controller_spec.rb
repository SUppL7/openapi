RSpec.describe Api::V3::RegistrationsController, type: :controller do
  let(:correct_password) { "#{Faker::Internet.password}!A3a" }
  let!(:user) { create(:user, :unconfirmed) }
  let(:password) { correct_password }
  let(:password_confirmation) { correct_password }
  let(:confirmation_token) { user.confirmation_token }

  describe '#create' do
    before { request.set_header('Content-Type', 'application/json') }
    subject do
      post :create,
      params: {
        confirmation_token: confirmation_token,
        user: {
          password: password,
          password_confirmation: password_confirmation
        }
      },
      format: :json
    end

    context 'when correct credentials' do
      it 'responds with JWT token' do
        response = subject
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['Authorization']).to match(/^Bearer\s\w/)
        user.reload
        expect(user.state).to eq :mail_confirmed
      end
    end

    context 'when incorrect password_confirmation' do
      let(:confirmation_token) { 'incorrect' }

      it 'responds with not found' do
        response = subject
        expect(response).to have_http_status(:not_found)
      end
    end

    context 'when incorrect password' do
      let(:password) { 'incorrect' }

      it 'responds with error' do
        response = subject
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body).dig('errors', 'password')).to be_present
      end
    end

    context 'when incorrect password_confirmation' do
      let(:password_confirmation) { 'incorrect' }

      it 'responds with error' do
        response = subject
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body).dig('errors', 'password_confirmation')).to be_present
      end
    end
  end
end
