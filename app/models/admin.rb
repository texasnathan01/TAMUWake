class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  devise :omniauthable, omniauth_providers: [:google_oauth2]
  def self.from_google(email:, full_name:, uid:, avatar_url:)
    if email == 'tamuwakeuser@gmail.com'
      create_with(uid: uid, first_name: full_name.split[0], last_name: full_name.split[1], avatar_url: "",
                  is_approved: true
      ).find_or_create_by!(email: email)
    else
      return nil unless /@tamu.edu\z/.match?(email)
        create_with(uid: uid, first_name: full_name.split[0], last_name: full_name.split[1], avatar_url: avatar_url).find_or_create_by!(email: email)
    end
  end

  # allows us to establish a connection between different tables and thus destroy relates entries when a user is deleted
  has_many :set_riders, dependent: :destroy
  has_many :wakeboard_sets, through: :set_riders
  has_many :set_drivers, dependent: :destroy
  has_many :set_roles, dependent: :destroy
  has_many :roles, through: :set_roles
  has_many :receipt, dependent: :destroy

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
  
  # this function is used to remove a role using the admin from the set role table
  def remove_role(role_id)
    user_role = SetRole.find_by(admin_id: self.id, role_id: role_id)
    # checks if the role already exists for the user
    # if it exists, it deletes it
    if user_role
      user_role.destroy
      return true
    # if it doesn't exist, it returns false
    else
      return false
    end
  
  # create 3 functions to determine whether account has a role or not
    
  
  rescue ActiveRecord::RecordNotSaved
    # db issue - role not added to user
    return false
  end

  def has_role?(role_name)
    return (self.roles.map { |role| role.role_name }).include?(role_name)
  end
end
