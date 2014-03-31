require 'nokogiri'
require 'open-uri'
require 'cgi'

class APICaller
  # makes the API call and returns the XML response for parsing
  def self.call_api(uri)
    begin
      xml = open(uri,:ssl_verify_mode => OpenSSL::SSL::VERIFY_NONE).read
    rescue => e
      raise e.message
    end
    Nokogiri::XML(xml)
  end
end