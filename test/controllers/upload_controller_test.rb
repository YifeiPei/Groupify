require 'test_helper'

class UploadControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end

  setup do 
    #login
    session[:user_id] = 1
  end

  test "should get index" do
    get :index
    assert_response :success
  end
end
