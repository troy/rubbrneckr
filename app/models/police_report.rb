class PoliceReport < ActiveRecord::Base
  belongs_to :crime_type
  belongs_to :crime_category
  belongs_to :incident_category
  
  validates_uniqueness_of :report_number
  
  default_scope :order => 'reporteddate DESC, occurdate DESC'

  named_scope :newest, :conditions => [ 'reporteddate >= ? OR occurdate >= ?', 18.hours.ago, 18.hours.ago ]  
  named_scope :recent, :conditions => [ 'reporteddate >= ? OR occurdate >= ?', 2.days.ago, 2.days.ago ]

  acts_as_mappable
  
  def to_s
    "#{address_formatted}: #{crime_type} (#{category}) - #{key_date} (#{report_number})"
  end
  
  def category
    crime_category || incident_category
  end
  
  def key_date
    reporteddate || occurdate
  end
  
  def address_formatted
    s = address.capitalize.gsub(/\b\w/){$&.upcase}
    s = s.gsub(/ (Ne|Nw|Se|Sw) /, &lambda {" #{$1.upcase} "})
    s.gsub(' Of ', ' of ')  
  end
  
  def report_url
    "http://web1.seattle.gov/police/records/PoliceReports/PoliceReport.ashx?go=#{report_number}"
  end
end
