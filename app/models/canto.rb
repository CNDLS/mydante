class Canto < Media
  
  
  def self.get_file_info(file_path)
    book_abbr = file_path.split("/")[-2]
    page_nbr = file_path.split("/").last.sub(/.*_canto/, "").to_i
    [book_abbr, page_nbr]
  end

  def self.get_stanzas(xml_doc)
    # return array of stanza nodes
    xml_doc.xpath("//page/p|//page/lg")
  end
  
  def self.get_lines(stanza_node)
    # from stanza node, return array of line nodes
    stanza_node.xpath("l")
  end
  
end