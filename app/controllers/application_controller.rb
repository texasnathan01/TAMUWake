class ApplicationController < ActionController::Base
    before_action :authenticate_admin!
    helper_method :current_user

    private

    def current_user
        # grabbing current userwho is logged in  
        User.find_by(:email => current_admin.email)
    end
    
        
end
