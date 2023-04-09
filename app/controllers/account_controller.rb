class AccountController < ApplicationController
  def index
    # grabbing current user using helper function
    @user = current_admin
    @roles = @user.set_roles
  end
end
