require 'rails_helper'

RSpec.describe Api::V1::RecommendationsController, type: :request do
  let(:user) { create(:user, level: "intermediate") }
  let!(:beginner_figure) { create(:figure, skill_level: "beginner") }
  let!(:intermediate_figure) { create(:figure, skill_level: "intermediate") }
  let!(:advanced_figure) { create(:figure, skill_level: "advanced") }
  let(:headers) { { "Authorization" => "Bearer #{JsonWebToken.encode(user_id: user.id)}" } }

  describe "GET /api/v1/recommendations" do
    context "when the user is authenticated" do
      it "returns recommendations adapted to the user's level" do
        get "/api/v1/recommendations", headers: headers
        expect(response).to have_http_status(:ok)
        json_response = JSON.parse(response.body)
        expect(json_response).not_to be_empty
        json_response.each do |figure|
          expect(["beginner", "intermediate"]).to include(figure["skill_level"])
        end
      end
    end

    context "when the user has mastered certain figures" do
      before { user.figures << beginner_figure }

      it "does not include figures already mastered" do
        get "/api/v1/recommendations", headers: headers
        json_response = JSON.parse(response.body)
        expect(json_response.any? { |fig| fig["id"] == beginner_figure.id }).to be_falsey
      end
    end

    context "when the user is not authenticated" do
      it "returns a 401 Unauthorized error" do
        get "/api/v1/recommendations"
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
