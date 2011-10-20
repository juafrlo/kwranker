require 'gscraper'
namespace :update_rankings do
  desc "Updating google ranking for every keyword"  
  task :google => :environment do
    Keyword.all.each do |kw|      
      GScraper::Search::WebQuery.const_set(:SEARCH_HOST, kw.google_domain)
      GScraper::Search::WebQuery.const_set(:SEARCH_URL, "http://#{kw.google_domain}/search")
      query = GScraper::Search.query(:query => kw.name, :results_per_page => 100)

      results_page = query.page(1)
      rank = results_page.ranks_of { |result| !result.url.to_s.scan(DOMAIN).blank? }.try(:first)
      unless rank.blank?
        Measurement.create(:keyword_id => kw.id, :value => rank)
      end
    end
  end
end
