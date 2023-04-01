module UsersHelper
    def has_documents_signed
        if current_admin.aor_completed == false || current_admin.dues_completed == false || current_admin.boat_waiver_completed
            flash[:error] = "Documents Not Yet Completed: " + (current_admin.dues_completed ? "" : "Dues ") + (current_admin.aor_completed ? "" : "AOR ") + (current_admin.boat_waiver_completed ? "" : "Boat Waiver ")
            return false
        else
            return true
        end
    end

    def has_info_filled_out(user_id)
        logger.info("user_id: #{user_id}")
        @user_to_check = Admin.find_by(id: user_id)
        if !@user_to_check.address.present? || !@user_to_check.uin.present?
            flash[:error] = "Info Not Yet Filled Out on Account: " + (@user_to_check.uin.present? ? "" : "UIN ") + (@user_to_check.address.present? ? "" : "Address ")+".Please fill this out on the Account Page."
            flash.discard(:error)
            return false
        else
            return true
        end
    end
end
