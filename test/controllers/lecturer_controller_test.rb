require 'test_helper'

class LecturerControllerTest < ActionController::TestCase

  test "should get index" do
    #login
    session[:user_id] = 1
    session[:err_msg] = []

    get :index
    assert_response :success
    assert_template layout: "layouts/lecturer_application"
  end

  test "should redirect"  do
    get :index
    assert_redirected_to(controller: "login", action: "login")
  end

end