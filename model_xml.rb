require 'nokogiri'

# used DataMapper::Serializer::XML::Nokogiri code
module ModelXml
  def new_document
    Nokogiri::XML::Document.new
  end


  def root_node(doc, name, attrs = {})
    root = Nokogiri::XML::Node.new(name, doc)

    attrs.each do |attr_name, attr_val|
      root[attr_name] = attr_val
    end

    doc.root.nil? ? doc.root = root : doc.root << root
    root
  end

  def add_node(parent, name, value, attrs = {})
    node = Nokogiri::XML::Node.new(name, parent.document)
    node << Nokogiri::XML::Text.new(value.to_s, parent.document) unless value.nil?

    attrs.each do |attr_name, attr_val|
      node[attr_name] = attr_val
    end

    parent << node
    node
  end

  def add_xml(parent, xml)
    parent << xml.root
  end

  def output(doc)
    doc.root.to_s
  end
end