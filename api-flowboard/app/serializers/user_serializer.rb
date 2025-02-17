class UserSerializer
  include JSONAPI::Serializer

  attributes :id, :email, :level, :session_duration, :created_at
  attribute :figures_mastered do |user|
    user.figures.pluck(:id)
  end
end
