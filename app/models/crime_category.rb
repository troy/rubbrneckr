class CrimeCategory < ActiveRecord::Base
  has_many :police_reports
  
  validates_uniqueness_of :name
  
  def to_s
    name
  end
end
