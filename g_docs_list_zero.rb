require "gdata/client"
require 'gdata/http'
require 'gdata/auth'
require "rexml/document"
require "rexml/element"




class GDocsListZero



  def self.initialize
    @@client = GData::Client::DocList.new
    @@client.clientlogin('ykaratv@gmail.com', 'Syncdocs01')
  end


  def self.get_quiz_files_list

    @@client = GData::Client::DocList.new
    @@client.clientlogin('ykaratv@gmail.com', 'Syncdocs01')

    @@feed = @@client.get('https://docs.google.com/feeds/documents/private/full').to_xml


    @@docs_list = REXML::Element.new("docs_list")
    @@feed.elements.each('entry') do |entry|


       if entry.elements['category'].attribute('label').value == "Flashcards Deluxe"

         doc = REXML::Element.new ("doc")
         doc.elements << entry.elements['title']
         doc.elements << entry.elements['id']

         @@docs_list.elements << doc

          #puts 'title: ' + entry.elements['title'].text
          #puts 'type: ' + entry.elements['category'].attribute('label').value
          #puts 'updated: ' + entry.elements['updated'].text
          #puts 'id: ' + entry.elements['id'].text

          # Extract the href value from each <atom:link>
          #links = {}
          #entry.elements.each('link') do |link|
          #  links[link.attribute('rel').value] = link.attribute('href').value
          #end

       end
    end

    #puts @@docs_list.to_s
    @@docs_list
  end

end

#GDocsListZero.get_quiz_files_list