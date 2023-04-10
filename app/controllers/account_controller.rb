class AccountController < ApplicationController
  def index
    # grabbing current user using helper function
    @user = current_admin
    @roles = @user.set_roles
  end

  def history
    @pagy, @sets = pagy_countless(current_admin.wakeboard_sets.order(scheduled_date: :desc), items: 10)

    respond_to do |format|
      format.html # GET
      format.turbo_stream # POST
    end
  end
end
