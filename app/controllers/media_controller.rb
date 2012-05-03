class MediaController < ApplicationController
  
  def show
    case params[:file_format]
    when "xml"
      file_path = params[:file_path]
      english_version = Media.get_xml(file_path)
      @english_stanzas = Media.get_stanzas(english_version)
      
      italian_version_path = file_path.sub("longfellow", "original")
      italian_version = Media.get_xml(italian_version_path)
      @italian_stanzas = Media.get_stanzas(italian_version)
      
      
      @page_nbr = file_path.split("/").last.sub(/.*_canto/, "").to_i
    end
  end
end
