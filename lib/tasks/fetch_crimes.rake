desc "Download & import crime data from City of Seattle. Argument: DURATION=<# of days before today (default 0)>"
task :fetch_crimes => :environment do
  duration = ENV['DURATION'].to_i || 0

  p = PoliceReportFetcher.new
  end_date = Time.now.strftime('%m/%d/%Y')
  start_date = duration.days.ago.strftime('%m/%d/%Y')

  CrimeCode.all.each do |c|
    p.get_crime_data(c.name, start_date, end_date)
    sleep 1
  end
end
