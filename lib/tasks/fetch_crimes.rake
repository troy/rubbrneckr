desc "Download & import crime data from City of Seattle. Argument: DURATION=<# of days before today (default 0)>"
task :fetch_crimes => :environment do
  history_days = ENV['DURATION'].to_i || 0

  police_report_fetcher = PoliceReportFetcher.new  
  if Time.now.hour % 3 == 0
    police_report_fetcher.get_all_crime_data(history_days.days.ago.strftime('%m/%d/%Y'), Time.now.strftime('%m/%d/%Y'))
  end

  police_report_fetcher.get_all_incident_data(history_days*24, 0)
end
