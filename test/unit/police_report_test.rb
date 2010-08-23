require 'test_helper'

class PoliceReportTest < ActiveSupport::TestCase
  context 'a PoliceReport' do
    setup do
      @police_report = police_reports(:two)
    end
    
    should 'capitalize the address correctly' do
      assert_equal '11xx Block of NW Other St', @police_report.address_formatted
    end
  end
end
