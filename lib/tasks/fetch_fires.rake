desc "Download & import current day's fire data from City of Seattle."
task :fetch_fires => :environment do
  fire_dispatch_fetcher = FireDispatchFetcher.new
  fire_dispatch_fetcher.get_fire_data
end
