class Image < Media
  
  def path(variant=nil)
    fname = variant ? File.basename(super(), ".jpg") + "_#{variant}.jpg" : super()
    source_id ? "source_#{'%04d' % source_id}/#{fname}" : fname
  end
end
