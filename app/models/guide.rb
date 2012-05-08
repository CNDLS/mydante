class Guide < Media
  attr_accessible :title, :path
  
  def path 
    "guides/" + super
  end
end
