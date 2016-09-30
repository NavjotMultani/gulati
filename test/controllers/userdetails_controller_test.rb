require 'test_helper'

class UserdetailsControllerTest < ActionController::TestCase
  test "should get userdetails" do
    get :userdetails
    assert_response :success
  end

end
