require 'test_helper'

class VentaControllerTest < ActionDispatch::IntegrationTest
  test "should get edit" do
    get venta_edit_url
    assert_response :success
  end

end
