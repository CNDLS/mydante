class Image < Media
  
  def path(variant=nil)
    fname = variant ? File.basename(super(), ".jpg") + "_#{variant}.jpg" : super()
    source_id ? "source_#{'%04d' % source_id}/#{fname}" : fname
  end
  
  
  def geometry
    @geometry unless @geometry.nil?
    
    begin
      info = IO.popen ("identify #{Rails.root}/app/assets/images/#{path}"){ |io| io.gets }
      geometry = info.split(" ")[2].split("x")
      @geometry = {:width => geometry[0], :height => geometry[1]}
    rescue
      @geometry = {:width => 0, :height => 0}
    end
  end
end
