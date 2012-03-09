class Person < ActiveRecord::Base
  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }
  
  has_one :user
  
  def name
    "#{first_name} #{last_name}"
  end
end