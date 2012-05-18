class Guide < Media
  
  def path(variant=nil)
    "guides/#{super()}"
  end
end
