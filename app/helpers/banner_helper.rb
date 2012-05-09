module BannerHelper

  def banner_url(options={})
    # default.
    return asset_path('banners/dante1.jpg') if options.nil?
    
    # cantos
    if book = options.fetch(:book)
      if page_nbr = options.fetch(:page_nbr)
        asset_path("banners/commedia/#{book}/#{book}_canto#{'%02d' % page_nbr}.jpg")
      else
        case book
        when "inf"
          asset_path('banners/alinari5.jpg')
        end
      end
    end
  end
end