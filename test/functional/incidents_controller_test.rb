require 'test_helper'

class IncidentsControllerTest < ActionController::TestCase
  context 'GET with a lat & lng' do
    setup do
      get :index, :lat => 47.6123, :lng => -122.3457
    end
    
    should_respond_with :success
    should_assign_to :incidents
    should 'find 1 incident' do
      assert_equal 1, assigns(:incidents).length
    end
  end
  
  context 'GET with a lat & lng outside of Seattle' do
    setup do
      get :index, :lat => 47.0, :lng => -122.0
    end
    
    should_respond_with :success
    should_assign_to :incidents
    should 'find 0 incidents' do
      assert_equal 0, assigns(:incidents).length
    end
  end
end