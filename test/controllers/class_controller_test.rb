require 'test_helper'

class ClassControllerTest < ActionController::TestCase

  test "should get index" do
  	#login
  	session[:user_id] = 1

    get :index
    assert_response :success
  end

  test "should redirect"  do
  	get :index
  	assert_redirected_to(controller: "login", action: "login")
  end

  test "create a class" do
  	#login
  	session[:user_id] = 1 

  	#params[:course][:name] = "Test Course"
  	#get(:create, {"course" => 'name["test"]'})
 	#assert_redirected_to(controller: "lecturer")
  end
end
