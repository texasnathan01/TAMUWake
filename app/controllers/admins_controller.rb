class AdminsController < ApplicationController
     before_action :check_user_approval
     before_action :set_admin, only: %i[show edit update destroy update_approval]

     def update_approval
          # validate that the user is editing info is admin
          if current_admin.role_id == 1 || current_admin.role_id >= 0
               respond_to do |format|
                    if @user.update(is_approved: true)
                         format.html do
                              redirect_to(users_to_approve_path,
                                          notice: "User #{@user.first_name} #{@user.last_name} was successfully approved."
                                         )
                         end
                         format.json { render(:show, status: :ok, location: @user) }
                    else
                         format.html { render(:edit, status: :unprocessable_entity) }
                         format.json { render(json: @user.errors, status: :unprocessable_entity) }
                    end
               end
          else
               # redirect to account if they do not have permission
               respond_to do |format|
                    format.html do
                         redirect_to(accounts_url,
                                     notice: 'You do not have access to this page. Contact your adminstrator for help.'
                                    )
                    end
               end
          end
     end

     def show; end
     def edit; end

     # PATCH/PUT /users/1 or /users/1.json
     def update
          # validate that the user is editing info is either admin or same user
          logger.info("params id: #{current_admin.email} and current_admin id #{@user.email}")
          logger.info((current_admin.email == @user.email).to_s)
          if current_admin.role_id == 1 || current_admin.role_id >= 0 || current_admin.email == @user.email
               respond_to do |format|
                    if @user.update(admin_params)
                         format.html do
                              redirect_to(user_url(@user), notice: 'User was successfully updated.')
                         end
                         format.json { render(:show, status: :ok, location: @user) }
                    else
                         format.html { render(:edit, status: :unprocessable_entity) }
                         format.json { render(json: @user.errors, status: :unprocessable_entity) }
                    end
               end
          else
               # redirect to account if they do not have permission
               respond_to do |format|
                    format.html do
                         redirect_to(accounts_url,
                                     notice: 'You do not have access to that update action. Contact your adminstrator for help.'
                                    )
                    end
               end
          end
     end

     def destroy
          @user.destroy!
          respond_to do |format|
               format.html { redirect_to(users_path, notice: 'User was successfully destroyed.') }
               format.json { head(:no_content) }
          end
     end

     # this function allows the admin to assign a role to a user
     def add_role
          user = Admin.find(params[:id])
          role = Role.find(params[:role_id])

          respond_to do |format|
               format.html do
                    redirect_to(user_url(user),
                                notice: 'Role has been successfully assigned to the user.'
                               )
               end
               format.html do
                    redirect_to(user_url(user),
                                notice: 'Role has been successfully assigned to the user.'
                               )
               end
               if user.add_role(role.id)
                    format.json { render(:show, status: :ok, location: user) }
               else
                    format.json do
                         render(json: { message: 'Role has already been assigned to the user. Could not assign it again' },
                                status: :expectation_failed
                               )
                    end
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
          params.require(:admin).permit(:email, :first_name, :last_name, :role_id, :address, :uin,
                                        :aor_completed, :boat_waiver_completed, :dues_completed, :is_approved
          )
     end

     def delete
          @users = Admin.find(params[:id])
     end
end
