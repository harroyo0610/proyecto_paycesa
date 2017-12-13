require 'test_helper'

class CuentasControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get cuentas_index_url
    assert_response :success
  end

end
