require 'nokogiri'

class PoliceIncidentParser
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
        :lat => report['yloc'],
        :lng => report['xloc'],
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
      next if PoliceReport.find_by_report_number(incident[:id])

      PoliceReport.create! :crime_type => CrimeType.find_or_create_by_name(incident[:crime_type]),
        :address => incident[:address], :lat => incident[:lat], :lng => incident[:lng],
        :occurdate => incident[:occurdate], :report_number => incident[:id],
        :incident_category => IncidentCategory.find_by_name(incident[:category])
    end
  end
end