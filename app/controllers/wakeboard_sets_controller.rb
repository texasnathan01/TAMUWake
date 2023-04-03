class WakeboardSetsController < ApplicationController
     before_action :set_wakeboard_set, only: %i[show edit update destroy]

     # GET /wakeboard_sets or /wakeboard_sets.json
     def index
          @wakeboard_sets = WakeboardSet.limit(10)

          # .where("scheduled_date >= ? AND scheduled_date <= ?",
          #  DateTime.current.beginning_of_week(start_date = :sunday).advance(hours: 8),
          #  DateTime.current.end_of_week(start_date = :sunday).advance(hours: -4)
          # )
     end

     # GET /wakeboard_sets/1 or /wakeboard_sets/1.json
     def show
          @joinable = !SetRider.rider_exists?(current_admin.id, params[:id])
          @riders = SetRider.where(wakeboard_set_id: params[:id]).joins(:admin).select(:first_name,
                                                                                       :last_name, :as_dib
          )
          @drivers = SetDriver.where(wakeboard_set_id: params[:id]).joins(:admin).select(:first_name,
                                                                                         :last_name
                                                                                        )
     end

     # GET /wakeboard_sets/new
     def new
          @wakeboard_set = WakeboardSet.new
     end

     # GET /wakeboard_sets/1/edit
     def edit; end

     # POST /wakeboard_sets or /wakeboard_sets.json
     def create
          @wakeboard_set = WakeboardSet.new(wakeboard_set_params.merge(driver_count: 1))

          respond_to do |format|
               if @wakeboard_set.save
                    user = current_admin
                    driver1 = SetDriver.new(admin_id: user.id, wakeboard_set_id: @wakeboard_set.id)
                    driver2 = SetDriver.new(admin_id: params[:wakeboard_set][:user_id],
                                            wakeboard_set_id: @wakeboard_set.id
                                           )

                    format.html do
                         redirect_to(wakeboard_set_url(@wakeboard_set),
                                     notice: 'Wakeboard set was successfully created.'
                                    )
                    end
                    format.json { render(:show, status: :created, location: @wakeboard_set) }
               else
                    format.html { render(:new, status: :unprocessable_entity) }
                    format.json do
                         render(json: @wakeboard_set.errors, status: :unprocessable_entity)
                    end
               end
          end
     end

     # PATCH/PUT /wakeboard_sets/1 or /wakeboard_sets/1.json
     def update
          respond_to do |format|
               if @wakeboard_set.update(wakeboard_set_params)
                    format.html do
                         redirect_to(wakeboard_set_url(@wakeboard_set),
                                     notice: 'Wakeboard set was successfully updated.'
                                    )
                    end
                    format.json { render(:show, status: :ok, location: @wakeboard_set) }
               else
                    format.html { render(:edit, status: :unprocessable_entity) }
                    format.json do
                         render(json: @wakeboard_set.errors, status: :unprocessable_entity)
                    end
               end
          end
     end

     # DELETE /wakeboard_sets/1 or /wakeboard_sets/1.json
     def destroy
          @wakeboard_set.destroy!

          respond_to do |format|
               format.html do
                    redirect_to(wakeboard_sets_url,
                                notice: 'Wakeboard set was successfully destroyed.'
                               )
               end
               format.json { head(:no_content) }
          end
     end

     # POST /sets/:id/join
     # This action is called whenever a rider attempts to join
     # a set either from the set itself or from the sets table
     # on the sets page
     def join
          @wakeboard_set = WakeboardSet.find(params[:id])
          as_dib = ActiveModel::Type::Boolean.new.cast(params[:as_dib])
          user = current_admin.id

          respond_to do |format|
               if has_documents_signed
                    if @wakeboard_set.join(user, as_dib)
                         format.html do
                              redirect_to(wakeboard_set_url(@wakeboard_set),
                                          notice: 'Successfully joined set'
                                         )
                         end
                         format.json { render(:show, status: :ok, location: @wakeboard_set) }
                    else
                         format.html { redirect_to(wakeboard_set_url(@wakeboard_set)) }
                         format.json do
                              render(json: { message: 'Unable to join set' },
                                     status: :expectation_failed
                                    )
                         end
                    end
               else
                    format.html { redirect_to(wakeboard_set_url(@wakeboard_set)) }
                    format.json do
                         render(json: { message: 'Unable to join set' },
                                status: :expectation_failed
                               )
                    end
               end
          end
     end

     # This action is called when a rider attempts to
     # leave a set
     def leave
          @set = WakeboardSet.find(params[:id])

          user = current_admin.id

          respond_to do |format|
               if @set.leave(user)
                    format.html do
                         redirect_to(wakeboard_set_url(@set), notice: 'Successfully left set')
                    end
                    format.json { render(:show, status: :ok, location: @set) }
               else
                    format.html do
                         redirect_to(wakeboard_set_url(@set), notice: 'Unable to leave set')
                    end
                    format.json do
                         render(json: { message: 'Unable to leave set' },
                                status: :expectation_failed
                               )
                    end
               end
          end
     end

     private

     # Use callbacks to share common setup or constraints between actions.
     def set_wakeboard_set
          @wakeboard_set = WakeboardSet.find(params[:id])
     end

     # Only allow a list of trusted parameters through.
     def wakeboard_set_params
          params.require(:wakeboard_set).permit(
               :dib_count,
               :dib_limit,
               :chib_count,
               :chib_limit,
               :driver_count,
               :driver_limit,
               :scheduled_date
          )
     end
end
