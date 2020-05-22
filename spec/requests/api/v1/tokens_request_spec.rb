require 'rails_helper'

RSpec.describe "Api::V1::Tokens", type: :request do

  let!(:user){ create(:user) }
  let(:valid_attributes) { { user: { email: 'test@gmail.com', password: '123456'} } }

  context 'when the authentication data is valid' do
    it "returns http success" do
      post "/api/v1/tokens/", params: valid_attributes
      expect(response).to have_http_status(:success)
    end
  end
end
