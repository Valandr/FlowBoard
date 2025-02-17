class Figure < ApplicationRecord
  validates :name, :description, :skill_level, :duration, :category, :video_url, presence: true
  enum :skill_level, { beginner: 0, intermediate: 1, advanced: 2 }, prefix: :skill
end
