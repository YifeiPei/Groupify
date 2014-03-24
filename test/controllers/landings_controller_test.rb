require 'test_helper'

class LandingsControllerTest < ActionController::TestCase
  setup do
    @landing = landings(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    #assert_not_nil assigns(:landings)
  end
end
