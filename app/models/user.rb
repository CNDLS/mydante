class User < ActiveRecord::Base
  # devise modules. Others available are -- :encryptable, :registerable, :confirmable, :rememberable, :trackable, :lockable, :timeoutable, :token_authenticatable, 
  devise :omniauthable
  
  # methods provided by devise:
  # before_filter :authenticate_user!
  # user_signed_in?
  # current_user
  # user_session

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :remember_me, :person_id, :username
  
  belongs_to :person
  
  def self.find_for_ldap_oauth(auth, current_user)
    user = self.find_or_initialize_by_username(uid_from_auth(auth))
    if user.id.nil?
      user.person = Person.create :first_name => eval(auth.user_info.first_name).first,
                                  :last_name => eval(auth.user_info.last_name).first
                                  
      user.email = eval(auth.user_info.email).first
    end
    user.save!
    user
  end
  
  
  def self.uid_from_auth(auth)
    # omniauth's uid comes back as a string of an array with one element that is a list. oy.
    uid = eval(auth.uid).first # "[\"uid=<username>, etc\"]" => \"uid=<username>, (etc)\"
    uid = eval("%w(#{uid})") # \"uid=<username>, etc\" => [\"uid=<username>\", ...]
    uid.map do |term|
      uid = term.sub("uid=", "")
      uid = uid.sub(",", "")
      return uid if not uid.empty?
    end
  end
  
end
