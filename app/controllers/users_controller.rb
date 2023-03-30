class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy]

  def search
    @products = Admin.where('is_approved = true AND first_name LIKE ? AND last_name LIKE ?', "%#{params[:first_name]}%", "%#{params[:last_name]}%")
    render json: @products
  end

  # GET /users or /users.json
  def index
    # need to check the role of the user
    @user = current_admin
    # added case for test TODO: need to remove
    if @user.role_id == 1 || @user.role_id >= -1 
      @users = if params[:first_name].present? || params[:last_name].present?
        Admin.where('is_approved = true AND first_name LIKE ? AND last_name LIKE ?', "%#{params[:first_name]}%", "%#{params[:last_name]}%")
      else
        Admin.where(is_approved: true) 
      end
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
    @user = current_admin
    # added case for test TODO: need to remove
    if @user.role_id == 1 || @user.role_id >= -1 
      @users = if params[:first_name].present? || params[:last_name].present?
        Admin.where('is_approved = false AND first_name LIKE ? AND last_name LIKE ?', "%#{params[:first_name]}%", "%#{params[:last_name]}%")
      else
        Admin.where(is_approved: false) 
      end
    else
      # redirect to account if they do not have permission
      respond_to do |format|
        format.html { redirect_to accounts_url, notice: "You do not have access to this page. Contact your adminstrator for help."}
      end
    end
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
