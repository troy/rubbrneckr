require File.dirname(__FILE__) + '/../test_helper'

class FireDispatchFetcherTest < ActiveSupport::TestCase
  context 'a FireDispatchFetcher' do
    context 'fetching dispatch data' do
      setup do
        FireDispatchFetcher.connection.build do |b|
          b.adapter :test do |stub|
            stub.get('/fire/realtime911/getRecsForDatePub.asp?incDate=&action=Today&rad1=des') { |env| [ 200, nil, static_data('fire_dispatch_1.html') ] }
          end
        end

        @fire_dispatch_fetcher = FireDispatchFetcher.new
        @fire_data = @fire_dispatch_fetcher.fire_data_request
      end
    
      should 'return parsable dispatch data markup' do
        assert @fire_data.match('Aid Response')
      end
    end
  end
end