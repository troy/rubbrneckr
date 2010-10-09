desc "Download & import crime data from City of Seattle. Argument: DURATION=<# of days before today (default 0)>"
task :fetch_crimes => :environment do
  history_days = ENV['DURATION'].to_i || 0

  police_report_fetcher = PoliceReportFetcher.new
  end_date = Time.now.strftime('%m/%d/%Y')
  start_date = history_days.days.ago.strftime('%m/%d/%Y')

  CrimeCategory.all.each do |category|
    police_report_fetcher.get_crime_data(category.name, start_date, end_date)
    sleep 0.2
  end
end
