require File.dirname(__FILE__) + '/../test_helper'

class FireDispatchParserTest < ActiveSupport::TestCase
  context 'a FireDispatchParser' do
    context 'parsing a series of dispatches' do
      setup do
        @fire_dispatch_parser = FireDispatchParser.new(static_data('fire_dispatch_1.html'))
        @incident = @fire_dispatch_parser.incidents[1]
      end
    
      should 'find the correct number of reports' do
        assert_equal 5, @fire_dispatch_parser.incidents.length
      end

      should 'find the correct data' do
        assert_equal '8/23/2010 10:39:00 AM', @incident[:occurred]
        assert_equal 'F100077318', @incident[:id]  
        assert_equal 'E5', @incident[:units]
        assert_equal '1111 E Madison St', @incident[:address]
        assert_equal 'Aid Response', @incident[:dispatch_type]
      end
      
      context 'saving as models' do
        setup do
          @fire_dispatch_parser.save
          @fire_dispatch = FireDispatch.last
        end
        
        should_change('FireDispatch count', :by => 5) { FireDispatch.count }
        
        should 'geocode' do
          assert_not_nil @fire_dispatch.lat
          assert_not_nil @fire_dispatch.lng
        end

        context 'saving a second time' do
          setup do

            @fire_dispatch_parser.save
          end
          
          should_not_change 'FireDispatch.count'
        end
      end
    end
  end
end