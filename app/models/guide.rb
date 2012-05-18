class Guide < Media
  
  def path(variant=nil)
    "guides/" + super(variant)
  end
end
