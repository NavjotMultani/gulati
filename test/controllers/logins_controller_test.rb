require 'test_helper'

class LoginsControllerTest < ActionController::TestCase
  test "should get logins" do
    get :logins
    assert_response :success
  end

end
