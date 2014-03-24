require 'test_helper'

class LoginControllerTest < ActionController::TestCase
  test "should get login" do
    get :login
    assert_response :success
  end

  test "log user in" do

    post(:login_attempt, {username_or_email: "test", login_password: "testing"})
    assert_redirected_to(controller: "lecturer")
  end

  test "login fail" do
    post(:login_attempt, {username_or_email: "test", login_password: "wrong_password"})
    assert_equal 'Invalid Username or Password', flash[:notice]
    assert_response :success
  end
end
