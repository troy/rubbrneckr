task :cron => :environment do
  Rake::Task["fetch_crimes"].invoke
end