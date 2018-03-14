require 'test_helper'

class DayControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get day_index_url
    assert_response :success
  end

end
