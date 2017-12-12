require 'test_helper'

class CotizacionControllerTest < ActionDispatch::IntegrationTest
  test "should get edit" do
    get cotizacion_edit_url
    assert_response :success
  end

end
