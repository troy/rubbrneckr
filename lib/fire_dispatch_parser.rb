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
      fire_dispatch = FireDispatch.find_by_dispatch_number(incident[:id])

      if fire_dispatch
        if incident[:units] != fire_dispatch.units
          # more units were dispatched since the last update
          fire_dispatch.units = incident[:units]
          fire_dispatch.save!
        end
        
        next
      end
      
      res = MultiGeocoder.geocode("#{incident[:address]}, Seattle, WA")

      FireDispatch.create! :dispatch_type =>  DispatchType.find_or_create_by_name(incident[:dispatch_type]), 
        :dispatch_number => incident[:id], :lat => res.lat, :lng => res.lng,
        :address => incident[:address], :occurred => incident[:occurred], :units => incident[:units]
    end
  end
end