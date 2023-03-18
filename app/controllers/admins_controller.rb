class AdminsController < ApplicationController
  before_action :set_admin, only: %i[ show edit update destroy]
  
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


  private
  # Use callbacks to share common setup or constraints between actions.
  def set_admin
    @user = Admin.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def admin_params
    params.require(:admin).permit(:email, :first_name, :last_name,:role_id,:documents_signed)
  end

  def delete
    @users = Admin.find(params[:id])
  end
end

