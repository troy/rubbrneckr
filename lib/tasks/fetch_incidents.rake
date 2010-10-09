desc "Download & import police incident data from City of Seattle. Argument: DURATION=<# of hours before now (default 6)>"
task :fetch_incidents => :environment do
  history_hours = ENV['DURATION'].to_i || 6

  police_report_fetcher = PoliceReportFetcher.new

  IncidentCategory.all.each do |category|
    police_report_fetcher.get_incident_data(category.name, history_hours, 0)
    sleep 0.2
  end
end
