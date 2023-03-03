class AccountController < ActionController::Base
    before_action :set_user, only: %i[ show edit update destroy ]

    def index
        @user = User.find_by(:email => current_admin.email)
    end
        
end
