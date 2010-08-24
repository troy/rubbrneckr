class FireDispatch < ActiveRecord::Base
  belongs_to :dispatch_type

  validates_uniqueness_of :dispatch_number
  
  default_scope :order => 'occurred DESC'
  
  named_scope :recent, :conditions => [ 'occurred >= ?', 1.day.ago ]
  named_scope :newest, :conditions => [ 'occurred >= ?', 90.minutes.ago ]  
  
  acts_as_mappable
  
  def to_s
    "#{address}: #{dispatch_type} - #{occurred} (#{dispatch_number})"
  end
end
