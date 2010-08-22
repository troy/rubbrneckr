require File.dirname(__FILE__) + '/../test_helper'

class PoliceReportFetcherTest < ActiveSupport::TestCase
  context 'a PoliceReportFetcher' do
    context 'fetching crime data' do
      setup do
        PoliceReportFetcher.connection.build do |b|
          b.adapter :test do |stub|
            stub.post('/MNM/ajax/Crime,App_Web_uywmdsag.ashx?_session=no&_method=GetCrimeData') { |env| [ 200, nil, static_data('multiple_reports_1.txt') ] }
          end
        end

        @police_report_fetcher = PoliceReportFetcher.new
        @crime_data = @police_report_fetcher.crime_data_request('Shoplifting', '8/14/2010', '8/21/2010')
      end
    
      should 'return parsable crime data markup' do
        assert @crime_data.match('occurDate')
      end
    end
    
    context 'fetching incident detail' do
      setup do
        PoliceReportFetcher.connection.build do |b|
          b.adapter :test do |stub|
            stub.post('/MNM/ajax/Crime,App_Web_uywmdsag.ashx?_session=no&_method=GetIncidentDetail') { |env| [ 200, nil, static_data('report_1.txt') ] }
          end
        end

        @police_report_fetcher = PoliceReportFetcher.new
      end
  
      should 'return parsable incident detail markup' do
        assert @police_report_fetcher.incident_detail_request('2010288847').match('address')
      end
    end
  end
end
