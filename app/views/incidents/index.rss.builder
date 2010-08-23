xml.instruct!

xml.rss "version" => "2.0", "xmlns:dc" => "http://purl.org/dc/elements/1.1/" do
  xml.channel do
    xml.title       "Seattle dispatches near #{@origin}"
    xml.link        incidents_url(params)
    xml.description "Police & fire dispatches"
 
    for incident in @incidents
      xml.item do
        xml.title       "#{incident.address}: #{incident.crime_type}"
        xml.description incident.to_s
      end
    end
  end
end