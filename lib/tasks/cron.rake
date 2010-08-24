task :cron => :environment do
  Rake::Task["fetch_crimes"].invoke
  Rake::Task["fetch_fires"].invoke
end