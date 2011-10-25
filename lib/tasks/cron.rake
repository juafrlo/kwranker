desc "This task is called by the Heroku cron add-on"
task :cron => :environment do
  if Time.now.hour == 5 
    puts 'Updating rankings'
    Rake::Task["update_rankings:google"].execute
  end
end