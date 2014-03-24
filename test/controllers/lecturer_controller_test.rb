require 'test_helper'

class LecturerControllerTest < ActionController::TestCase

  setup do 
    #login
    session[:user_id] = 1
    session[:err_msg] = []
  end

  test "should get index" do
    get :index
    assert_response :success
  end

end
