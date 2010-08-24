class PoliceReport < ActiveRecord::Base
  belongs_to :crime_type
  belongs_to :crime_category
  
  validates_uniqueness_of :report_number
  
  default_scope :order => 'reporteddate DESC'

  named_scope :newest, :conditions => [ 'reporteddate >= ?', 2.hours.ago ]  
  named_scope :recent, :conditions => [ 'reporteddate >= ?', 1.day.ago ]

  acts_as_mappable
  
  def to_s
    "#{address_formatted}: #{crime_type} (#{crime_category}) - #{reporteddate} (#{report_number})"
  end
  
  def address_formatted
    s = address.capitalize.gsub(/\b\w/){$&.upcase}
    s = s.gsub(/ (Ne|Nw|Se|Sw) /, &lambda {" #{$1.upcase} "})
    s.gsub(' Of ', ' of ')  
  end
end
