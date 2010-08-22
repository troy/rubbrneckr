require File.dirname(__FILE__) + '/../test_helper'

class PoliceReportFetcherTest < ActiveSupport::TestCase
  context 'a PoliceReportParser' do
    context 'parsing a series of reports' do
      setup do
        @police_report_parser = PoliceReportParser.new(static_data('multiple_reports_2.txt'))
      end

      should 'remove escaped quotes' do
        assert_equal 'Shoplifting.png', @police_report_parser.strip_escapes('\"Shoplifting.png\"')
      end
    
      should 'find the correct number of reports' do
        assert_equal 5, @police_report_parser.incidents.length
      end

      should 'parse a category' do
        assert_equal 'Shoplifting', @police_report_parser.category
      end

      should 'find the correct data' do
        assert_equal 'THEFT-SHOPLIFT', @police_report_parser.incidents[2][:crime_type]
        assert_equal '-122.339559377', @police_report_parser.incidents[2][:lng]
      end
      
      context 'saving as models' do
        setup do
          @police_report_parser.save
        end
        
        should_change('PoliceReport count', :by => 5) { PoliceReport.count }

        context 'saving a second time' do
          setup do

            @police_report_parser.save
          end
          
          should_not_change 'PoliceReport.count'
        end
      end
    end
  end
end
