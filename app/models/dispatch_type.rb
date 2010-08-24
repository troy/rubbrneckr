class DispatchType < ActiveRecord::Base
  has_many :fire_dispatches
  
  validates_uniqueness_of :name
end
