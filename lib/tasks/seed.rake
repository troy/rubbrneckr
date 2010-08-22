require 'rubygems'
require 'rake'

Rake::Task["db:test:prepare"].enhance do
  Rake::Task["db:seed_fu"].invoke
end

# Make sure running migrate task also runs seed task
Rake::Task["db:migrate"].enhance do
  puts "\n\nSeeding Data..."
  Rake::Task["db:seed_fu"].invoke
end
