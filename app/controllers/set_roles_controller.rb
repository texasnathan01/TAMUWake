class SetRolesController < ApplicationController
  before_action :set_set_role, only: %i[ show edit update destroy ]

  # GET /set_roles or /set_roles.json
  def index
    @set_roles = SetRole.all
  end

  # GET /set_roles/1 or /set_roles/1.json
  def show
  end

  # GET /set_roles/new
  def new
    @set_role = SetRole.new
  end

  # GET /set_roles/1/edit
  def edit
  end

  # POST /set_roles or /set_roles.json
  def create
    @set_role = SetRole.new(set_role_params)

    respond_to do |format|
      if @set_role.save
        format.html { redirect_to set_role_url(@set_role), notice: "Set role was successfully created." }
        format.json { render :show, status: :created, location: @set_role }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @set_role.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /set_roles/1 or /set_roles/1.json
  def update
    respond_to do |format|
      if @set_role.update(set_role_params)
        format.html { redirect_to set_role_url(@set_role), notice: "Set role was successfully updated." }
        format.json { render :show, status: :ok, location: @set_role }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @set_role.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /set_roles/1 or /set_roles/1.json
  def destroy
    @set_role.destroy

    respond_to do |format|
      format.html { redirect_to set_roles_url, notice: "Set role was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_set_role
      @set_role = SetRole.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def set_role_params
      params.require(:set_role).permit(:role_id_id, :user_id_id)
    end
end
