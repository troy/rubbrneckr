desc "Download & import current day's fire data from City of Seattle."
task :fetch_fires => :environment do
  FireDispatchFetcher.new.get_fire_data
end
