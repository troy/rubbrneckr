require File.dirname(__FILE__) + '/../test_helper'

class PoliceIncidentParserTest < ActiveSupport::TestCase
  context 'a PoliceIncidentParser' do
    context 'parsing a series of incidents' do
      setup do
        @police_incident_parser = PoliceIncidentParser.new(static_data('police_incidents_1.txt'))
      end

      should 'find the correct number of incidents' do
        assert_equal 3, @police_incident_parser.incidents.length
      end

      should 'parse a category' do
        assert_equal 'Weapon', @police_incident_parser.category
      end

      should 'find the correct data' do
        assert_equal 'PERSON WITH A GUN', @police_incident_parser.incidents[0][:crime_type]
        assert_equal '-122.313473608', @police_incident_parser.incidents[0][:lng]
      end
      
      context 'saving as models' do
        setup do
          @police_incident_parser.save
        end
        
        should_change('PoliceReport count', :by => 3) { PoliceReport.count }

        context 'saving a second time' do
          setup do
            @police_incident_parser.save
          end
          
          should_not_change 'PoliceReport.count'
        end
      end
    end
  end
end
