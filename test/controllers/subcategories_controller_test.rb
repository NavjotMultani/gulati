require 'test_helper'

class SubcategoriesControllerTest < ActionController::TestCase
  test "should get subcategories" do
    get :subcategories
    assert_response :success
  end

end
