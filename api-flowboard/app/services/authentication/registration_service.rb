require "ostruct"

module Authentication
  class RegistrationService
    attr_reader :user, :errors

    def initialize(params)
      @params = params
      @errors = []
    end

    def call
      figures = Figure.where(id: @params.delete(:figures_mastered)) 
      @user = User.new(@params)

      if @user.save
        @user.figures << figures 
        OpenStruct.new(success?: true, user: @user, errors: [])
      else
        OpenStruct.new(success?: false, user: nil, errors: @user.errors.full_messages)
      end
    end
  end
end
