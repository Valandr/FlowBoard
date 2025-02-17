module Api
  module V1
    class AuthController < ApplicationController
      skip_before_action :authorize_request, only: [:login, :signup]

      def login
        user = User.find_by(email: params[:email])

        if user&.authenticate(params[:password])
          token = JsonWebToken.encode(user_id: user.id)
          render json: { user: user.slice(:id, :email, :level, :session_duration), token: token }, status: :ok
        else
          render json: { error: "Incorrect email or password" }, status: :unauthorized
        end
      end

      def signup
        user = User.new(user_params.except(:figures_mastered))
        if user.save
          user.assign_figures_mastered(params[:user][:figures_mastered]) if params[:user][:figures_mastered].present?
          token = JsonWebToken.encode(user_id: user.id)
          render json: { user: user.slice(:id, :email, :level, :session_duration), token: token }, status: :created
        else
          render json: { error: user.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def logout
        head :no_content
      end

      private

      def user_params
        params.require(:user).permit(:email, :password, :password_confirmation, :level, :session_duration, figures_mastered: [])
      end
    end
  end
end
