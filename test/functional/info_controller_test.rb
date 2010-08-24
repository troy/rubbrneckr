require 'test_helper'

class InfoControllerTest < ActionController::TestCase
  context 'GET to :index' do
    setup do
      get :index
    end
    
    should_respond_with :success
  end
end
