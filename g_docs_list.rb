require 'gdata/client'
require 'gdata/http'
require 'gdata/auth'
require 'nokogiri'


class GDocsList
  def self.initialize
    @@client = GData::Client::DocList.new
    @@client.clientlogin('ykaratv@gmail.com', 'Syncdocs01')
  end




end