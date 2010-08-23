xml.instruct!

xml.rss "version" => "2.0", "xmlns:dc" => "http://purl.org/dc/elements/1.1/" do
  xml.channel do
    xml.title       "Emergencies near #{@origin}"
    xml.link        emergencies_url(params)
    xml.description "Seattle-area police & fire dispatches"
 
    for emergency in @emergencies
      xml.item do
        xml.title       "#{emergency.address_formatted}: #{emergency.crime_type}"
        xml.description emergency.to_s
      end
    end
  end
end
