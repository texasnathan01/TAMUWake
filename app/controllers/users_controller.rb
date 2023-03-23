class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy]

  # GET /users or /users.json
  def index
    # need to check the role of the user
    @user = current_admin
    # added case for test TODO: need to remove
    if @user.role_id == 1 || @user.role_id >= -1 
      @users = Admin.all
    else
      # redirect to account if they do not have permission
      respond_to do |format|
        format.html { redirect_to accounts_url, notice: "You do not have access to this page. Contact your adminstrator for help."}
      end
    end
  end

  # GET /users/1 or /users/1.json
  def show
  end

  def approval
    @users = Admin.where('role_id < 0')
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: "User was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = Admin.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def delete
      @users = Admin.find(params[:id])
    end

end
