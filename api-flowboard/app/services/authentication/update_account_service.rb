module Authentication
  class UpdateAccountService
    attr_reader :user, :errors

    def initialize(user, params)
      @user = user
      @params = params
      @errors = []
    end

    def call
      if @user.update(@params)
        OpenStruct.new(success?: true, user: @user, errors: [])
      else
        OpenStruct.new(success?: false, user: nil, errors: @user.errors.full_messages)
      end
    end
  end
end
