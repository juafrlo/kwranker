class Keyword < ActiveRecord::Base
  has_many :measurements
  
  def self.latest_measurements
    measurements = []
    Keyword.all.each do |kw|
      measurements << kw.latest_measurement
    end
    measurements.compact.uniq
  end

  def latest_measurement
    self.measurements.sort_by{|k| k.created_at}.last
  end
  
end
