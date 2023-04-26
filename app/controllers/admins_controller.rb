class AdminsController < ApplicationController
  before_action :set_admin, only: %i[show edit update destroy update_approval]

  def update_approval
    # validate that the user is editing info is admin
    if current_admin.has_role?("Admin")
      respond_to do |format|
        if @user.update(is_approved: true)
          format.html { redirect_to(users_to_approve_path, notice: "User #{@user.first_name} #{@user.last_name} was successfully approved.") }
          format.json { render(:show, status: :ok, location: @user) }
        else
          format.html { render(:edit, status: :unprocessable_entity) }
          format.json { render(json: @user.errors, status: :unprocessable_entity) }
        end
      end
    else
      # redirect to account if they do not have permission
      respond_to do |format|
        format.html { redirect_to(accounts_url, notice: "You do not have access to this page. Contact your adminstrator for help.") }
      end
    end
  end

  def show 
    if current_admin.has_role?("Admin") || current_admin.email == @user.email
      # retrieving the roles associated to the user
      @roles = @user.set_roles 
    else
      # redirect to account if they do not have permission
      respond_to do |format|
        format.html { redirect_to(accounts_url, notice: "You do not have access to that page. Contact your adminstrator for help.") }
      end
    end
  end
  
  def edit
    if current_admin.has_role?("Admin") || current_admin.email == @user.email
      # retrieving the roles associated to the user
      @roles = @user.set_roles 
    else
      # redirect to account if they do not have permission
      respond_to do |format|
        format.html { redirect_to(accounts_url, notice: "You do not have access to that page. Contact your adminstrator for help.") }
      end
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    # validate that the user is editing info is either admin or same user
    # logger.info("params id: #{current_admin.email} and current_admin id #{@user.email}")
    if current_admin.has_role?("Admin") || current_admin.email == @user.email
      respond_to do |format|
        if @user.update(admin_params)
          format.html { redirect_to(admin_path(@user), notice: "User was successfully updated.") }
          format.json { render(:show, status: :ok, location: @user) }
        else
          format.html { render(:edit, status: :unprocessable_entity) }
          format.json { render(json: @user.errors, status: :unprocessable_entity) }
        end
      end
    else
      # redirect to account if they do not have permission
      respond_to do |format|
        format.html { redirect_to(accounts_url, notice: "You do not have access to that update action. Contact your adminstrator for help.") }
      end
    end
  end

  def destroy
    # logger.info(params)
    @user.destroy!
    respond_to do |format|
      if (params[:action] == "approval")
        format.html { redirect_to(users_to_approve_path, notice: "Account was successfully denied.") }
        format.json { head(:no_content) }
      else
        format.html { redirect_to(users_path, notice: "User was successfully destroyed.") }
        format.json { head(:no_content) }
      end
    end
  end

  # this function allows the admin to assign a role to a user
  def add_role
    user = Admin.find(params[:id])
    role = Role.find(params[:role_id])

    respond_to do |format|
      if !user.add_role(role.id)
        format.html { redirect_to edit_admin_path(user), notice: "Role has already been assigned to the user. Could not assign it again" }
        format.json { render json:{ message: "Role has already been assigned to the user. Could not assign it again" }, status: :expectation_failed }
      else
        format.html { redirect_to edit_admin_path(user), notice: "Role has been assigned to the user." }
        format.json { render :show, status: :ok, location: user }
      end
    end
  end
  
  # this function allows the admin to delete a role from a user
  def remove_role
    user = Admin.find(params[:id])
    role = Role.find(params[:role_id])
    
    # rendering the view to display the status message
    respond_to do |format|
      if !user.remove_role(role.id)
        format.html { redirect_to edit_admin_path(user), notice: "Role does not exist for the user. Could not remove it." }
        format.json { render json:{ message: "Role does not exist for the user. Could not remove it." }, status: :expectation_failed}
      else
        format.html { redirect_to edit_admin_path(user), notice: "Role has been removed successfully." }
        format.json { render :show, status: :ok, location: user}
      end
    end
  end

  # this function allows the admin to view all the roles assigned to a user
  # def show_role
  #   user = Admin.find(params[:id])
  #   # retrieving the roles associated to the user
  #   @roles = user.set_roles 

  #   # rendering the view to display the roles
  #   respond_to do |format|
  #     # views > admin > show.html.erb
  #     format.html 
  #     format.json {render json: @roles}
  #   end
  # end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_admin
    @user = Admin.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def admin_params
    params.require(:admin).permit(:first_name, :last_name, :role_id, :address, :uin, :aor_completed, :boat_waiver_completed, :dues_completed,
                                  :is_approved
    )
  end

  def delete
    @users = Admin.find(params[:id])
  end
end
