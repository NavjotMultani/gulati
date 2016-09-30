require 'test_helper'

class TaxesControllerTest < ActionController::TestCase
  test "should get taxes" do
    get :taxes
    assert_response :success
  end

end
