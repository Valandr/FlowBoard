module Authentication
  class SessionService
    attr_reader :user, :errors

    def initialize(params)
      @params = params
      @errors = []
    end

    def call
      @user = User.find_by(email: @params[:email])

      if @user&.valid_password?(@params[:password])
        OpenStruct.new(success?: true, user: @user, errors: [])
      else
        OpenStruct.new(success?: false, user: nil, errors: ["Invalid email or password"])
      end
    end
  end
end
