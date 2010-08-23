xml.instruct!

xml.rss "version" => "2.0", "xmlns:dc" => "http://purl.org/dc/elements/1.1/" do
  xml.channel do
    xml.atom :link, nil, {
      :href => emergencies_url(params),
      :rel => 'self', :type => 'application/rss+xml'
    }
    
    xml.title       "Emergencies near #{@origin}"
    xml.description "Seattle-area police & fire dispatches"
    xml.link        emergencies_url(params)
 
    for emergency in @emergencies
      xml.item do
        xml.title       "#{emergency.address_formatted}: #{emergency.crime_type}"
        xml.description emergency.to_s
        xml.pubDate     emergency.updated_at
        xml.guid        "#{emergency.reporteddate}-#{emergency.report_number}", :isPermalink => false
        xml.geo         :lat, emergency.lat
        xml.geo         :long, emergency.lng
      end
    end
  end
end
