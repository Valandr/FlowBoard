module Api
  module V1
    class FiguresController < ApplicationController
      skip_before_action :authorize_request
      def index
        figures = Figure.all
        render json: figures, status: :ok
      end
    end
  end
end
