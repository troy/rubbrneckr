require 'csv'

desc "Generate CSV of all fires and crimes"
task :csv => :environment do
  CSV::Writer.generate(STDOUT) do |csv|
    PoliceReport.find(:all, :limit => 10).each do |p|
      csv << [p.report_number,  p.key_date, p.crime_type, p.category, p.incident_type, p.address_formatted, p.lat, p.lng, p.report_url]
    end
  end
end