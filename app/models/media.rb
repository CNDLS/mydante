require 'haml'

class Media < ActiveRecord::Base
  
  has_many :edits
  
  def self.get_xml(file_path)
    f = File.read("#{Rails.root}/app#{ActionController::Base.helpers.asset_path(file_path)}.xml")
    doc = Nokogiri::XML(f)
    # xslt = Nokogiri::XSLT(File.read("#{Rails.root}/app/assets/texts/commedia/canto.xslt"))
    # xslt.transform(doc)
  end

  def self.get_stanzas(xml_doc)
    # return array of stanza nodes
    xml_doc.xpath("//page/p|//page/plg")
  end
  
  def self.get_lines(stanza_node)
    # from stanza node, return array of line nodes
    stanza_node.xpath("l")
  end
  
end
