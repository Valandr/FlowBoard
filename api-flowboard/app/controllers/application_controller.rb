class ApplicationController < ActionController::API
  before_action :authorize_request, unless: -> { self.class == Api::V1::AuthController }

  def authorize_request
    header = request.headers["Authorization"]
    token = header.split(" ").last if header

    decoded = JsonWebToken.decode(token)
    @current_user = User.find_by(id: decoded[:user_id]) if decoded

    render json: { error: "unauthorized" }, status: :unauthorized unless @current_user
  end
end
