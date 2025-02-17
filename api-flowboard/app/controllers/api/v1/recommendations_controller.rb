module Api
  module V1
    class RecommendationsController < ApplicationController
      before_action :authorize_request

      def index
        user = @current_user
        mastered_figures = user.figures.pluck(:id) 

        skill_levels = ['beginner', 'intermediate', 'advanced']

        user_skill_index = skill_levels.index(user.level) || 0

        allowed_levels = skill_levels[0..user_skill_index]

        recommended_figures = Figure.where.not(id: mastered_figures)
                                    .where(skill_level: allowed_levels)
                                    .order(Arel.sql("RANDOM()"))
                                    .limit(5)

        render json: recommended_figures, status: :ok
      rescue StandardError => e
        render json: { error: "Internal server error : #{e.message}" }, status: :internal_server_error
      end
    end
  end
end
