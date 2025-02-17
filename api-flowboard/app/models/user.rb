class User < ApplicationRecord
  has_secure_password

  has_and_belongs_to_many :figures

  enum :level, { beginner: 0, intermediate: 1, advanced: 2 }, prefix: :level

  validates :session_duration, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true

  def generate_jwt
    payload = { user_id: id, exp: 7.days.from_now.to_i }
    JWT.encode(payload, Rails.application.secrets.secret_key_base)
  end

  def assign_figures_mastered(figure_ids)
    self.figures = Figure.where(id: figure_ids)
  end
end
