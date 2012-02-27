class Edit < ActiveRecord::Base
  has_one :person, :foreign_key => :editor_id
  has_one :post, :foreign_key => :subject_id, :conditions => "`subject_type` = 'Post'"
  has_one :media, :foreign_key => :subject_id, :conditions => "`subject_type` = 'Media'"
end
