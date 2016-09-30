require 'test_helper'

class MaincategoriesControllerTest < ActionController::TestCase
  test "should get maincategories" do
    get :maincategories
    assert_response :success
  end

end
