desc "This task is called by the Heroku cron add-on"
task :cron => :environment do
  if Time.now.hour == 22 
    puts 'Updating rankings'
    `heroku run rake update_rankings:google --trace`
  end
end