class ImagesController < InheritedResources::Base
  
  def inline
    @image = Image.find(params[:image_id])
    render :layout => false
  end
end
