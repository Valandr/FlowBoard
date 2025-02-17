module Authentication
  class DeleteAccountService
    attr_reader :user, :errors

    def initialize(user)
      @user = user
      @errors = []
    end

    def call
      if @user.destroy
        OpenStruct.new(success?: true, user: nil, errors: [])
      else
        OpenStruct.new(success?: false, user: @user, errors: ["Error while deleting account”."])
      end
    end
  end
end
