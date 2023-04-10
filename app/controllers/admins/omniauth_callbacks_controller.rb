class Admins::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google_oauth2
    admin = Admin.from_google(**from_google_params)
    #needed for admin account NOTE: important that this account is protected via admins and not shared to those without permission
    if admin.email == "tamuwakeuser@gmail.com"
      #gives admin account all roles on login
      Role.all.map.each do |role|
        puts role.role_name
        admin.add_role(role.id)
      end
    end
    if admin.present?
      #needed for admin account NOTE: important that this account is protected via admins and not shared to those without permission
      if admin.email == "tamuwakeuser@gmail.com"
        #gives admin account all roles on login
        Role.all.map.each do |role|
          puts role.role_name
          admin.add_role(role.id)
        end
      end
      sign_out_all_scopes
      flash[:success] = t('devise.omniauth_callbacks.success', kind: 'Google')
      sign_in_and_redirect(admin, event: :authentication)
    else
      flash[:alert] = t('devise.omniauth_callbacks.failure', kind: 'Google', reason: "#{auth.info.email} is not authorized or not a TAMU account.")
      redirect_to(new_admin_session_path)
    end
  end

  protected

  def after_omniauth_failure_path_for(_scope)
    new_admin_session_path
  end

  def after_sign_in_path_for(resource_or_scope)
    stored_location_for(resource_or_scope) || root_path
  end

  private

  def from_google_params
    @from_google_params ||= {
      uid: auth.uid,
      email: auth.info.email,
      full_name: auth.info.name,
      avatar_url: auth.info.image
    }
  end

  def auth
    @auth ||= request.env['omniauth.auth']
  end
end
