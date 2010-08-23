class PoliceReport < ActiveRecord::Base
  belongs_to :crime_type
  belongs_to :crime_category
  
  validates_uniqueness_of :report_number
  
  default_scope :order => 'reporteddate DESC'
  
  named_scope :recent, :conditions => [ 'reporteddate >= ?', 1.day.ago ]

  acts_as_mappable
  
  def to_s
    "#{address}: #{crime_type} (#{crime_category}) - #{reporteddate} (#{report_number})"
  end
end
