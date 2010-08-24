xml.instruct!

xml.rss "version" => "2.0", "xmlns:dc" => "http://purl.org/dc/elements/1.1/", "xmlns:geo" => "http://www.w3.org/2003/01/geo/wgs84_pos#"  do
  xml.channel do
    xml.atom :link, nil, {
      :href => emergencies_url(params),
      :rel => 'self', :type => 'application/rss+xml'
    }
    
    xml.title       "Emergencies near #{@origin}"
    xml.description "Seattle-area police & fire dispatches"
    xml.link        emergencies_url(params)
 
    for police_report in @police_reports
      xml.item do
        xml.title       "#{police_report.address_formatted}: #{police_report.crime_type}"
        xml.description police_report.to_s
        xml.pubDate     police_report.updated_at
        xml.guid        "#{police_report.reporteddate.to_i}-#{police_report.report_number}", :isPermalink => false
        xml.geo         :lat, police_report.lat
        xml.geo         :long, police_report.lng
      end
    end
    
    for fire_dispatch in @fire_dispatches
      xml.item do
        xml.title       "#{fire_dispatch.address}: #{fire_dispatch.dispatch_type}"
        xml.description fire_dispatch.to_s
        xml.pubDate     fire_dispatch.updated_at
        xml.guid        "#{fire_dispatch.occurred.to_i}-#{fire_dispatch.dispatch_number}", :isPermalink => false
        xml.geo         :lat, fire_dispatch.lat
        xml.geo         :long, fire_dispatch.lng
      end
    end
  end
end
