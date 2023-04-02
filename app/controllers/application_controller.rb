class ApplicationController < ActionController::Base
    before_action :authenticate_admin!
    # append_before_action :check_user_approval

    private

    def check_user_approval
        if current_admin && current_admin.is_approved?
            flash[:alert] = "Your coount is not yet approved yet. Please wait for approval or contact your Administrators."
            redirect_to new_admin_session_path
        end 
    end
end
