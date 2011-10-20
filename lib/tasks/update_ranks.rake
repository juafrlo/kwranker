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
      rank = results_page.ranks_of { |result| !result.url.to_s.scan(DOMAIN).blank? }.try(:first) rescue nil
      Measurement.create(:keyword_id => kw.id, :value => rank.blank? ? "No en los 100 primeros" : rank)
    end
  end
end
