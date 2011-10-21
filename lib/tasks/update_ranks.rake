# encoding: UTF-8
require 'gscraper'
namespace :update_rankings do
  desc "Updating google ranking for every keyword"  
  task :google => :environment do

    Keyword.all.each do |kw|
      GScraper::Search::WebQuery.const_set(:SEARCH_HOST, kw.google_domain)
      GScraper::Search::WebQuery.const_set(:SEARCH_URL, "http://#{kw.google_domain}/search")
      query = GScraper::Search.query(:query => kw.name, :results_per_page => 100)
      results_page = query.page(1) rescue nil
      if results_page.present?
        rank = results_page.ranks_of do |result| 
          begin 
            !result.url.host.scan(DOMAIN).blank?
          rescue Exception => e  
            puts "\033[31mException caught for #{kw.name}\033[0m"
            puts e.message  
            puts e.backtrace.inspect
            false
          end
        end
      end
      rank = rank.try(:first) 
      m = Measurement.create(:keyword_id => kw.id, :value => rank.to_i == 0 ? nil : rank)
      kw.latest_measurement = m.id
      kw.save      
      puts "\033[32mRank for #{kw.name} is #{rank.to_i}\033[0m"
    end
  end
end
