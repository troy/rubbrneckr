require 'test_helper'

class EmergenciesControllerTest < ActionController::TestCase
  context 'GET to locator' do
    setup do
      get :locator
    end
    
    should_respond_with :success
  end

  context 'GET with a lat & lng' do
    setup do
      @location = { :lat => 47.6123, :lng => -122.3457 }
    end
    
    context 'requesting HTML' do
    setup do
      get :index, @location
    end
    
    should_respond_with :success
    should_assign_to :police_reports
    should_assign_to :fire_dispatches
    should_assign_to :search_query
    
    should 'find the right number of emergencies' do
      assert_equal 2, assigns(:police_reports).length
    end
  end
    
    context 'requesting RSS' do
      setup do
        get :index, @location.merge(:format => 'rss')
      end
      
      should_respond_with :success
    end      
  end
  
  context 'GET with a lat & lng outside of Seattle' do
    setup do
      get :index, :lat => 47.0, :lng => -122.0
    end
    
    should_respond_with :success
    should 'find 0 emergencies' do
      assert_equal 0, assigns(:police_reports).length
    end
  end
  
  context 'GET with a street address and a huge range' do
    setup do
      get :index, :address => '5th & wall', :d => 500
    end

    should_respond_with :success
    should 'find 3 emergencies' do
      assert_equal 3, assigns(:police_reports).length
    end
  end
end