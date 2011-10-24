class Keyword < ActiveRecord::Base
  has_many :measurements
  has_one :latest_m, :class_name => 'Measurement', :order => 'measurements.id desc'
end
