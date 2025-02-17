require 'rails_helper'

RSpec.describe Figure, type: :model do
  describe "Validations" do
    it "is valid with a name, description, level and video" do
      figure = Figure.new(name: "Kickflip", description: "Flip in the air", skill_level: "intermediate", video_url: "https://youtube.com/example")
      expect(figure).to be_valid
    end

    it "is not valid without a name" do
      figure = Figure.new(description: "Flip in the air", skill_level: "intermediate", video_url: "https://youtube.com/example")
      expect(figure).not_to be_valid
    end

    it "is not valid without a level of difficulty" do
      figure = Figure.new(name: "Kickflip", description: "Flip in the air", video_url: "https://youtube.com/example")
      expect(figure).not_to be_valid
    end

    it "is invalid with incorrect level" do
      figure = Figure.new(name: "Impossible Trick", description: "Très difficile", skill_level: "expert", video_url: "https://youtube.com/example")
      expect(figure).not_to be_valid
    end
  end

  describe "Associations" do
    it "can be mastered by several users" do
      should have_and_belong_to_many(:users)
    end
  end
end
