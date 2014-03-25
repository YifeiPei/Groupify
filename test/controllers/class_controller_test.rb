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

  test "create a class error" do
  	#login
  	session[:user_id] = 1 

  	get(:create, {"course" => {"name" => "meh"}}, {"err_msg" => Array.new})

 	  assert_redirected_to(controller: "lecturer")
    assert_not_equal(session[:err_msg][1], "Course name cannot be blank.")
    assert_equal(session[:err_msg][2], "You need to import a file.")
    assert_equal(session[:err_msg][4], "Group size cannot less than 0.")
  end

  test "create a class success" do
    #login
    session[:user_id] = 1 

    file = fixture_file_upload("access_adelaide.csv", "text/csv")

    get(:create, {"course" => {"name" => "Test Course"}, "filename" => "test.csv", "file"=>file, "group_size" => 2}, {"err_msg" => Array.new})

    assert_redirected_to(controller: "sort", action: "advanced_sort")
  end
end
