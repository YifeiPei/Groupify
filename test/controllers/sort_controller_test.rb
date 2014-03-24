require 'test_helper'

class SortControllerTest < ActionController::TestCase

  setup do 
    #login
    session[:user_id] = 1
    session[:course_id] = 1
  end

  test "should get index" do
    get :index
    assert_response :success
  end

end
