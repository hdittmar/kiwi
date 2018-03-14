require 'test_helper'

class TypeControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get type_show_url
    assert_response :success
  end

end
