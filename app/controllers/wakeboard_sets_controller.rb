class WakeboardSetsController < ApplicationController
  before_action :set_wakeboard_set, only: %i[ show edit update destroy ]

  # GET /wakeboard_sets or /wakeboard_sets.json
  def index
    @wakeboard_sets = WakeboardSet.all
  end

  # GET /wakeboard_sets/1 or /wakeboard_sets/1.json
  def show
  end

  # GET /wakeboard_sets/new
  def new
    @wakeboard_set = WakeboardSet.new
  end

  # GET /wakeboard_sets/1/edit
  def edit
  end

  # POST /wakeboard_sets or /wakeboard_sets.json
  def create
    @wakeboard_set = WakeboardSet.new(wakeboard_set_params)

    respond_to do |format|
      if @wakeboard_set.save
        format.html { redirect_to wakeboard_set_url(@wakeboard_set), notice: "Wakeboard set was successfully created." }
        format.json { render :show, status: :created, location: @wakeboard_set }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @wakeboard_set.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /wakeboard_sets/1 or /wakeboard_sets/1.json
  def update
    respond_to do |format|
      if @wakeboard_set.update(wakeboard_set_params)
        format.html { redirect_to wakeboard_set_url(@wakeboard_set), notice: "Wakeboard set was successfully updated." }
        format.json { render :show, status: :ok, location: @wakeboard_set }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @wakeboard_set.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /wakeboard_sets/1 or /wakeboard_sets/1.json
  def destroy
    @wakeboard_set.destroy

    respond_to do |format|
      format.html { redirect_to wakeboard_sets_url, notice: "Wakeboard set was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_wakeboard_set
      @wakeboard_set = WakeboardSet.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def wakeboard_set_params
      params.require(:wakeboard_set).permit(:rider_limit, :current_rider_count, :scheduled_date)
    end
end
