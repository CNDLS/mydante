class MediaController < ApplicationController
  
  def show
    case params[:file_format]
    when "xml"
      @media = Media.get_xml(params[:file_path])
    end
  end
end
