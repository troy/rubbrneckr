require 'nokogiri'

class FireDispatchParser
  include Geokit::Geocoders
  
  attr_reader :body, :parsed
  
  def initialize(html)
    @body = html
    @parsed =  Nokogiri::HTML(@body)
  end
  
  def incidents
    incidents = []
    @parsed.xpath('//tr[@id]').each do |row|
      incident = {
        :occurred => row.children[0].children.first.text,
        :id => row.children[2].children.first.text,
        :units => row.children[6].children.first.text,
        :address => row.children[8].children.first.text,
        :dispatch_type => row.children[10].children.first.text
      }

      incidents << incident
    end
    
    incidents
  end
  
  def save
    incidents.each do |incident|
      dispatch_type = DispatchType.find_or_create_by_name(incident[:dispatch_type])

      fire_dispatch = FireDispatch.find_or_create_by_dispatch_number(incident[:id])
    
      # GeoKit
      if fire_dispatch.lat || fire_dispatch.lng
        lat = fire_dispatch.lat
        lng = fire_dispatch.lng
      else
        res = MultiGeocoder.geocode("#{incident[:address]}, Seattle, WA")
        lat = res.lat
        lng = res.lng
      end

      fire_dispatch.update_attributes :dispatch_type => dispatch_type, :dispatch_number => incident[:id],
        :address => incident[:address], :occurred => incident[:occurred], :units => incident[:units],
        :lat => lat, :lng => lng
    end
  end
end