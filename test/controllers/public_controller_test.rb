require 'test_helper'

class PublicControllerTest < ActionController::TestCase
  test "should get public" do
    get :public
    assert_response :success
  end

end
