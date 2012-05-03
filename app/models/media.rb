require 'haml'

class Media < ActiveRecord::Base
  
  has_many :edits
  
  def self.get_xml(file_path)
    f = File.read("#{Rails.root}/app#{ActionController::Base.helpers.asset_path(file_path)}.xml")
    doc = Nokogiri::XML(f)
    xslt = Nokogiri::XSLT(File.read("#{Rails.root}/app/assets/texts/commedia/canto.xslt"))
    m = xslt.transform(doc).to_s
    # m.errors.inspect
  end
  
end
