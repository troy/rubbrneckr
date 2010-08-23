xml.instruct!

xml.rss "version" => "2.0", "xmlns:dc" => "http://purl.org/dc/elements/1.1/" do
  xml.channel do
    xml.title       "Emergencies near #{@origin}"
    xml.link        incidents_url(params)
    xml.description "Seattle-area police & fire dispatches"
 
    for incident in @incidents
      xml.item do
        xml.title       "#{incident.address_formatted}: #{incident.crime_type}"
        xml.description incident.to_s
      end
    end
  end
end
