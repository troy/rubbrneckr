require 'faraday'

class PoliceReportFetcher
  def self.connection
    @connection ||= Faraday::Connection.new(:url => 'http://web5.seattle.gov')
  end

  def connection
    self.class.connection
  end
  
  def crime_request(&block)
    connection.post do |req|
      req['Content-Type'] = 'application/xml'
      req['Cache-Control'] = 'max-age=0'
      req['Origin'] = 'http://web5.seattle.gov'
      req['Referer'] = 'http://web5.seattle.gov/mnm/policereports.aspx'
      req['User-Agent'] = 'Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_6_4; en-us) AppleWebKit/533.17.8 (KHTML, like Gecko) Version/5.0.1 Safari/533.17.8'

      yield req
    end
  end
  
  def get_crime_data(type, start_date, end_date)
    PoliceReportParser.new(crime_data_request(type, start_date, end_date)).save
  end
  
  def crime_data_request(type, start_date, end_date)
    # expected without leading zero
    start_date.sub!(/^0/, '')
    end_date.sub!(/^0/, '')
    
    r = crime_request do |req|
      req.url "/MNM/ajax/Crime,App_Web_uywmdsag.ashx?_method=GetCrimeData&_session=no"
      req.body = "topleft=47.743825019093656, -122.43833543383
bottomRight=47.35789706038656, -122.14359329028322
startDate=#{start_date}
endDate=#{end_date}
offenseCode=#{type}"
      # @body="'<iconCol layerId=\"Shoplifting\"><icon id=\"2010292563\" name=\"THEFT-SHOPLIFT\" reportedDate=\"8/21/2010 2:45:00 PM\" occurDate=\"8/21/2010 2:45:00 PM\"  address=\"4XX BLOCK OF PINE ST\" url=\"True\"  xLoc=\"-122.337320426\" yLoc=\"47.611321241\" image=\"Shoplifting.png\" /></iconCol>'"
    end
    
    r.body
  end
  
# turns out there's no use for this; the result is duplicative and a bit different
  def incident_detail_request(report_number)
    r = crime_request do |req|
      req.url "/MNM/ajax/Crime,App_Web_uywmdsag.ashx?_method=GetIncidentDetail&_session=no"
      req.body = "GONumber=#{report_number}"
      # @body="'<icon id=\"2010288847\" name=\"&lt;img src=\\'images/crime/Arrest.png\\' border=\\'0\\' style=&quot;padding-right:5px;&quot;/&gt;WARRARR-MISDEMEANOR\" reportedDate=\"8/18/2010 8:52:00 PM\" occurDate=\"8/18/2010 8:52:00 PM\"  address=\"12XX BLOCK OF THOMAS ST\" url=\"GEN\"  />'"
    end
    
    r.body
  end
end