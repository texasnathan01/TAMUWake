class WakeboardSetsController < ApplicationController
  before_action :set_wakeboard_set, only: %i[ show edit update destroy ]

  # GET /wakeboard_sets or /wakeboard_sets.json
  def index
    @wakeboard_sets = WakeboardSet.where("scheduled_date >= ? AND scheduled_date <= ?",
      DateTime.current.beginning_of_week(start_date = :sunday), 
      DateTime.current.end_of_week(start_date = :sunday)
    ).joins(:user)
  end

  # GET /wakeboard_sets/1 or /wakeboard_sets/1.json
  def show
    @riders = Rider.includes(:user).joins(:set_rider).where("wakeboard_set_id = ?", params[:id])
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
	 
	  setID = params[:id]
	  @set = WakeboardSet.find(setID)
	  user = params[:user_id]
	  rider = Rider.find_by(:user_id => user)
	  setdriver = SetDriver.new(date_registered: DateTime.current, rider_id: rider.id, wakeboard_set_id: setID)
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

  # POST /sets/:id/join
  def join
    setID = params[:id]
    @set = WakeboardSet.find(setID)
    user = params[:user_id]
    rider = Rider.find_by(:user_id => user)

    respond_to do |format|
      # if there are no spots available send an error
      if @set.current_rider_count >= @set.rider_limit
        @set.errors.add(:current_rider_count, message: ": The set is currently full")
        format.html { render :show, status: :unprocessable_entity }
        format.json { render json: @set.errors, status: :unprocessable_entity }
      end

      # first make a rider if not already made
      if !rider
        rider = Rider.new(documents_signed: false, user_id: user)
        if !rider.save
          rider.errors.add(:id, message: ": Rider couldn't be saved")
          format.html { render :show, status: :unprocessable_entity }
          format.json { render json: rider.errors, status: :unprocessable_entity }
        end
      end

      # next add the rider to the set
      setrider = SetRider.new(date_registered: DateTime.current, rider_id: rider.id, wakeboard_set_id: setID)
      @set.current_rider_count = @set.current_rider_count + 1
      if setrider.save && @set.save
        format.html { redirect_to wakeboard_set_url(@set), notice: "Successfully joined set." }
        format.json { render :show, status: :ok, location: @set }
      end
    end

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_wakeboard_set
      @wakeboard_set = WakeboardSet.includes(:user).find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def wakeboard_set_params
      params.require(:wakeboard_set).permit(
        :rider_limit, 
        :current_rider_count, 
        :scheduled_date, 
        :user_id
      )
    end
end
