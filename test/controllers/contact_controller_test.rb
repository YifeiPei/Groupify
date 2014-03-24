require 'test_helper'

class ContactControllerTest < ActionController::TestCase
  setup do 
    #login
    session[:user_id] = 1
    session[:course_id] = 1
  end

  test "should get contact" do
    get :contact
    assert_response :success
  end

end
