class FireDispatch < ActiveRecord::Base
  belongs_to :dispatch_type

  validates_uniqueness_of :dispatch_number
  
  default_scope :order => 'occurred DESC'

  named_scope :newest, :conditions => [ 'occurred >= ?', 11.hours.ago ]    
  named_scope :recent, :conditions => [ 'occurred >= ?', 1.day.ago ]
  
  acts_as_mappable
  
  def to_s
    "#{address}: #{dispatch_type} - #{occurred} (#{dispatch_number})"
  end
  
  def unit_count
    units.split(' ').count
  end
end
