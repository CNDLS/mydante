class MediaController < ApplicationController
  
  def show
    case params[:file_format]
    when "xml"
      file_path = params[:file_path]
      english_version = Media.get_xml(file_path)
      @english_stanzas = Canto.get_stanzas(english_version)
    
      italian_version_path = file_path.sub("longfellow", "original")
      italian_version = Media.get_xml(italian_version_path)
      @italian_stanzas = Canto.get_stanzas(italian_version)
    
      @book, @page_nbr  = Canto.get_file_info(file_path)
      @book_name = ""
      case @book
      when "inf"
        @book_name = "Inferno"
      when "purg"
        @book_name = "Purgatorio"
      when "par"
        @book_name = "Paradiso"
      end
    
      @banner_options = { :book => @book, :page_nbr => @page_nbr }
    end
  end
end
