require 'csv'

desc "Generate CSV of all fires"

namespace :export do
  task :fire => :environment do
    CSV::Writer.generate(STDOUT) do |csv|
      csv << ['Dispatch Number', 'Occurred', 'Address', 'Lat', 'Lng', 'Dispatch Type', 'Unit Count', 'Units']

      FireDispatch.all.each do |f|
        csv << [f.dispatch_number, f.occurred, f.address, f.lat, f.lng, f.dispatch_type, f.unit_count, f.units]
      end
    end
  end
  
  task :police => :environment do
    CSV::Writer.generate(STDOUT) do |csv|
      csv << ['Report Number', 'Occurred', 'Reported', 'Address', 'Lat', 'Lng', 'Crime Type', 'Crime Category', 'Incident Type', 'Report URL']

      PoliceReport.all.each do |p|
        csv << [p.report_number,  p.occurdate, p.reporteddate, p.address_formatted, p.lat, p.lng, p.crime_type, p.category, p.incident_type, p.report_url]
      end
    end
  end
end