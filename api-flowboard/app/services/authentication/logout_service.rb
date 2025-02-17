module Authentication
  class LogoutService
    attr_reader :user, :errors

    def initialize(user)
      @user = user
      @errors = []
    end

    def call
      if @user
        OpenStruct.new(success?: true, user: nil, errors: [])
      else
        OpenStruct.new(success?: false, user: @user, errors: ["Utilisateur introuvable"])
      end
    end
  end
end
