class MediaController < ApplicationController
  
  def show
    respond_to do |format|
      format.html do
        file_path = params[:file_path]
        english_version = Media.get_xml(file_path)
        @english_stanzas = Canto.get_stanzas(english_version)
    
        italian_version_path = file_path.sub("longfellow", "original")
        italian_version = Media.get_xml(italian_version_path)
        @italian_stanzas = Canto.get_stanzas(italian_version)
    
        @book_abbr, @page_nbr  = Canto.get_file_info(file_path)
        @book = Book.find_by_path("commedia/longfellow/#{@book_abbr}")
        @image_placements = TextSelection.by_page(@book.id, @page_nbr)
    
        @banner_options = { :book => @book_abbr, :page_nbr => @page_nbr }
        render :template => "media/show.html.haml"
      end
    end
  end
end
