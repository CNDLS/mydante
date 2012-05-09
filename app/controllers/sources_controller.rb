class SourcesController < InheritedResources::Base
  
  def show
    @source = Source.find(params[:id])
    @images = Media.find_all_by_source_id(@source.id)
  end
end
