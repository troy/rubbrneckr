require 'nokogiri'

class PoliceReportParser
  attr_reader :body, :parsed
  
  def initialize(htmlish)
    @body = htmlish.gsub('\"', '"')
    @parsed =  Nokogiri::HTML(@body)
  end
  
  def category
    if !@parsed.xpath('//iconcol').empty?
      strip_escapes(@parsed.xpath('//iconcol').first.attributes['layerid'].value)
    end
  end
  
  def strip_escapes(s)
    s.gsub('\"', '') if s
  end
  
  def incidents
    incidents = []
    @parsed.xpath('//icon').each do |report|
      next unless report['id'].present?
      
      raw_incident = {
        :id => report['id'],
        :crime_type => report['name'],
        :address => report['address'],
        :url => report['url'],
        :icon_url => report['image'],
        :lat => report['yloc'],
        :lng => report['xloc'],
        :reporteddate => report['reporteddate'],
        :occurdate => report['occurdate']
      }
      
      incident = {}
      raw_incident.each_pair { |k,v| incident[k] = strip_escapes(v) }
      
      incident[:category] = category unless category.blank?
      incidents << incident
    end
    
    incidents
  end
  
  def save
    incidents.each do |incident|
      police_report = PoliceReport.find_or_create_by_report_number(incident[:id])

      next unless police_report.new_record?

      crime_type = CrimeType.find_or_create_by_name(incident[:crime_type])

      police_report.update_attributes :crime_type => crime_type,
        :address => incident[:address], :url => incident[:url],
        :icon_url => incident[:icon_url], :lat => incident[:lat], :lng => incident[:lng],
        :reporteddate => incident[:reporteddate], :occurdate => incident[:occurdate],
        :crime_category => CrimeCategory.find_by_name(incident[:category])
    end
  end
end