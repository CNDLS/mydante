class User < ActiveRecord::Base
  devise :omniauthable
  
  belongs_to :person
  
  
  def self.find_or_create_from_ldap(auth)
    user = find_or_initialize_by_username(uid_from_ldap_auth(auth))
    if user.id.nil?
      first_name_from_ldap = eval(auth.user_info.first_name).first
      last_name_from_ldap = eval(auth.user_info.last_name).first
      user.person = Person.find_or_initialize_by_first_name_and_last_name(first_name_from_ldap, last_name_from_ldap)
                                  
      user.email = eval(auth.user_info.email).first
    end
    user.save!
    user
  end
  
  
  def self.uid_from_ldap_auth(auth)
    # omniauth ldap's uid comes back as a string of an array with one element that is a list. oy.
    uid = auth.uid
    uid = eval("%w(#{uid})") # \"uid=<username>, etc\" => [\"uid=<username>\", ...]
    uid.map do |term|
      uid = term.sub("uid=", "")
      uid = uid.sub(",", "")
      return uid if not uid.empty?
    end
  end
  
  
  def self.find_or_create_from_shibboleth(auth)
    p auth.inspect
  end
  
  
  def name
    person.name
  end
  
end
