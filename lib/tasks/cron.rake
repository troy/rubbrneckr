task :cron => :environment do
  #Rake::Task["fetch_crimes"].invoke
  #Rake::Task["fetch_fires"].invoke

  if Time.now.hour % 2 == 0
    police_report_fetcher = PoliceReportFetcher.new
    end_date = Time.now.strftime('%m/%d/%Y')
    start_date = 1.day.ago.strftime('%m/%d/%Y')

    CrimeCategory.all.each do |category|
      police_report_fetcher.get_crime_data(category.name, start_date, end_date)
      sleep 0.1
    end
  end
  
  fire_dispatch_fetcher = FireDispatchFetcher.new
  fire_dispatch_fetcher.get_fire_data
end