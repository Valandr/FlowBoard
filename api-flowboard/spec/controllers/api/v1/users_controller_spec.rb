require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :request do
  describe "POST /api/v1/users" do
    let(:valid_params) do
      { user: { email: "test@example.com", password: "password123", password_confirmation: "password123", level: "beginner", session_duration: 30 } }
    end

    let(:invalid_params) do
      { user: { email: "", password: "", password_confirmation: "", level: "beginner", session_duration: 30 } }
    end

    let(:conflicting_params) do
      existing_user = create(:user, email: "test@example.com")
      { user: { email: existing_user.email, password: "password123", password_confirmation: "password123", level: "beginner", session_duration: 30 } }
    end

    context "when information is valid" do
      it "creates a user and returns a token" do
        post "/api/v1/users", params: valid_params
        expect(response).to have_http_status(:created)
        json_response = JSON.parse(response.body)
        expect(json_response).to have_key("token")
        expect(json_response["user"]["email"]).to eq("test@example.com")
      end
    end

    context "when information is invalid" do
      it "returns a 422 Unprocessable Entity error" do
        post "/api/v1/users", params: invalid_params
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context "when the email already exists" do
      it "returns an error and does not create the user" do
        post "/api/v1/users", params: conflicting_params
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
