class AdminsController < ApplicationController
  before_action :set_admin, only: %i[ show edit update destroy update_approval]
  
  def update_approval
    respond_to do |format| 
      if @user.update(is_approved: true)
        format.html { redirect_to users_to_approve_path, notice: "User #{@user.first_name} #{@user.last_name} was successfully approved." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def show
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_path, notice: "User was successfully destroyed." }
      format.json { head :no_content }
    end
  end
  
  # PATCH/PUT /users/1 or /users/1.json
  def update
    
    respond_to do |format|
      if @user.update(admin_params)
        format.html { redirect_to user_url(@user), notice: "User was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # this function allows the admin to assign a role to a user
  def add_role
    user = Admin.find(params[:id])
    role = Role.find(params[:role_id])

    respond_to do |format|
      if !user.add_role(role.id)
        format.html { redirect_to user_url(user), notice: "Role has been successfully assigned to the user." }
        format.json { render json:{ message: "Role has already been assigned to the user. Could not assign it again" }, status: :expectation_failed }
      else
        format.html { redirect_to user_url(user), notice: "Role has been successfully assigned to the user." }
        format.json { render :show, status: :ok, location: user }
      end
    end
  end
  
  private
  # Use callbacks to share common setup or constraints between actions.
  def set_admin
    @user = Admin.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def admin_params
    params.require(:admin).permit(:email, :first_name, :last_name, :role_id,:address,:uin,:documents_signed, :is_approved)
  end

  def delete
    @users = Admin.find(params[:id])
  end
end

