module ProustGuiHelper
  
  class MenuItemsFromFilesFactory < GuiHelper::MenuItemsFromFilesFactory
    def item_from_filename(rendering_context, filename)
      ProustGuiHelper::MenuItem.new(File.basename(filename), rendering_context.asset_path(@directory +"/"+ filename))
    end
  end
  
  
  class MenuItem < GuiHelper::MenuItem
    def label
      page_nbr = /\d*/.match(name.split("_").last).string.to_i.to_s
      "Page #{page_nbr}"
    end
  end
    
end