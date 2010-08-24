require 'faraday'

class FireDispatchFetcher
  def self.connection
    @connection ||= Faraday::Connection.new(:url => 'http://www2.seattle.gov')# do |builder|
  end

  def connection
    self.class.connection
  end
  
  def fire_data_request
    r = connection.get do |req|
      req['Referer'] = 'http://www2.seattle.gov/fire/realtime911/getRecsForDatePub.asp?action=Today&incDate=&rad1=des'
      req['User-Agent'] = 'Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_6_4; en-us) AppleWebKit/533.17.8 (KHTML, like Gecko) Version/5.0.1 Safari/533.17.8'
      req.url '/fire/realtime911/getRecsForDatePub.asp?action=Today&incDate=&rad1=des'
    end
    
    r.body
  end
  
  def get_fire_data
    FireDispatchParser.new(fire_data_request).save
  end
end