task :cron => :environment do
  #Rake::Task["fetch_crimes"].invoke
  #Rake::Task["fetch_fires"].invoke
  
  fire_dispatch_fetcher = FireDispatchFetcher.new
  fire_dispatch_fetcher.get_fire_data

  police_report_fetcher = PoliceReportFetcher.new  
  if Time.now.hour % 3 == 0
    end_date = Time.now.strftime('%m/%d/%Y')
    start_date = 1.day.ago.strftime('%m/%d/%Y')

    CrimeCategory.all.each do |category|
      police_report_fetcher.get_crime_data(category.name, start_date, end_date)
      sleep 0.1
    end
  end

  IncidentCategory.all.each do |category|
    police_report_fetcher.get_incident_data(category.name, 2, 0)
    sleep 0.2
  end
end