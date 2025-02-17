require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validations" do
    it "is valid with a valid email and password" do
      user = User.new(email: "test@example.com", password: "password123", level: :beginner, session_duration: 30)
      expect(user).to be_valid
    end

    it "is not valid without email" do
      user = User.new(password: "password123")
      expect(user).not_to be_valid
    end

    it "is invalid if the password is too short" do
      user = User.new(email: "test@example.com", password: "123")
      expect(user).not_to be_valid
    end
    describe "Associations" do
      it "peut maîtriser plusieurs figures" do
        should have_and_belong_to_many(:figures)
      end
    end
  
    describe "Méthodes d'instance" do
      let(:user) { create(:user) }
      let!(:figure1) { create(:figure) }
      let!(:figure2) { create(:figure) }
  
      it "génère un jeton JWT valide" do
        token = user.generate_jwt
        expect(token).not_to be_nil
      end
  
      it "attribue des figures maîtrisées" do
        user.assign_figures_mastered([figure1.id, figure2.id])
        expect(user.figures).to include(figure1, figure2)
      end
    end
  end
end
