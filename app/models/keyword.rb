class Keyword < ActiveRecord::Base
  has_many :measurements
  has_one :latest_m, :class_name => 'Measurement', :order => 'measurements.id desc'

  def last_30_measurements
    self.measurements.find(:all, :limit => 30, :order => 'id desc').reverse
  end
end
