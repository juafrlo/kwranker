desc "This task is called by the Heroku cron add-on"
task :cron => :environment do
  puts 'Updating rankings'
  Rake::Task["update_rankings:google"].execute
end