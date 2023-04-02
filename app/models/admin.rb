class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  
  devise :omniauthable, omniauth_providers: [:google_oauth2]
  def self.from_google(email:, full_name:, uid:, avatar_url:)
    return nil unless email =~ /@tamu.edu\z/ || email == 'tamuwakeuser@gmail.com'
    create_with(uid: uid,first_name: full_name.split[0],last_name: full_name.split[1], avatar_url: avatar_url).find_or_create_by!(email: email)
  end

  has_many :wakeboard_set, dependent: :destroy
  has_many :set_roles, dependent: :destroy
  # allows us to establish a connection between roles and set_roles
  has_many :roles, :through => :set_roles

  # this function is used to add a role using the admin to the set role table
  def add_role(role_id)
    user_role = SetRole.new(
      admin_id: self.id,
      role_id: role_id
    )
    # checks if the role already exists for the user
    if (self.roles.map { |role| role.id }).include?(role_id)
      return false
    end
    user_role.save!
    # role successfully added to user
    return true

  rescue ActiveRecord::RecordNotSaved
    # db issue - role not added to user
    return false
  end
end