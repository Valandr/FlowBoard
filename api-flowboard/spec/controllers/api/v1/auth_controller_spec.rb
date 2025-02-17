require 'rails_helper'

RSpec.describe Api::V1::AuthController, type: :request do
  let(:user) { create(:user, password: 'password123') }
  let(:valid_credentials) { { email: user.email, password: 'password123' } }
  let(:invalid_credentials) { { email: user.email, password: 'wrongpassword' } }

  describe "POST /api/v1/auth/login" do
    context "with valid logins" do
      it "returns a token and user information" do
        post "/api/v1/auth/login", params: valid_credentials
        expect(response).to have_http_status(:ok)
        json_response = JSON.parse(response.body)
        expect(json_response).to have_key("token")
        expect(json_response["user"]["email"]).to eq(user.email)
      end
    end

    context "with invalid identifiers" do
      it "returns an authentication error" do
        post "/api/v1/auth/login", params: invalid_credentials
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe "POST /api/v1/auth/signup" do
    let(:new_user_params) do
      { user: { email: "newuser@example.com", password: "password123", password_confirmation: "password123", level: "beginner", session_duration: 30 } }
    end

    it "creates a new user and returns a token" do
      post "/api/v1/auth/signup", params: new_user_params
      expect(response).to have_http_status(:created)
      json_response = JSON.parse(response.body)
      expect(json_response).to have_key("token")
      expect(json_response["user"]["email"]).to eq("newuser@example.com")
    end
  end

  describe "DELETE /api/v1/auth/logout" do
    it "returns status 204 with no content" do
      delete "/api/v1/auth/logout"
      expect(response).to have_http_status(:no_content)
    end
  end
end
