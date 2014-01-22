require 'test_helper'

class ClassControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

end
