class TextSelection < ActiveRecord::Base
  belongs_to :book, :class_name => :media
  belongs_to :media
  
  scope :by_page, lambda { |book_id, page_nbr|
    where(:book_id => book_id, :page_nbr => page_nbr)
  }
  
  scope :by_stanza, lambda { |first_line_of_stanza_nbr|
    where("line_nbr >= #{first_line_of_stanza_nbr} and line_nbr <= #{first_line_of_stanza_nbr + 2}")
  }
end
