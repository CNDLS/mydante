require 'haml'

class Media < ActiveRecord::Base
  
  has_many :edits
  
  def self.get_xml(file_path)
    f = File.read("#{Rails.root}/app/assets/#{file_path}.xml")
    doc = Nokogiri::XML(f)
    # xslt = Nokogiri::XSLT(File.read("#{Rails.root}/app/assets/texts/commedia/canto.xslt"))
    # xslt.transform(doc)
  end
  
end
