RSpec.describe Api::V1::CountriesController, type: :controller do
  let!(:student) { Student.find(user.id) }
  let(:headers) { { 'Accept' => 'application/json', 'Content-Type' => 'application/json' } }
  let(:auth_headers) { Devise::JWT::TestHelpers.auth_headers(headers, api_user) }

  let!(:country1) { create(:country) }
  let!(:country2) { create(:country) }

  before { request.headers.merge!(auth_headers) }

  describe '#index' do
    context 'when no auth token' do
      let(:auth_headers) {{}}

      subject { get :index, format: :json }

      it 'responds with unauthorized' do
        expect(subject).to have_http_status(:unauthorized)
      end
    end

    context 'when no pagination' do
      subject { get :index, format: :json }

      it 'responds with full collection without meta' do
        response = subject
        expect(response).to have_http_status(:ok)
        body = JSON.parse(response.body)
        expect(body['countries'].size).to eq 2
        expect(body['meta']).to be_nil
      end
    end

    context 'when pagination' do
      subject { get :index, params: { page: 1, per_page: 1 }, format: :json }

      it 'responds collection per page with meta' do
        response = subject
        expect(response).to have_http_status(:ok)
        body = JSON.parse(response.body)
        expect(body['countries'].size).to eq 1
        expect(body['meta']).to eq({'current_page'=>1, 'next_page'=>2, 'prev_page'=>nil, 'total_count'=>2, 'total_pages'=>2})
      end
    end
  end
end
