require 'test_helper'

class EmbarqueControllerTest < ActionDispatch::IntegrationTest
  test "should get edit" do
    get embarque_edit_url
    assert_response :success
  end

  test "should get index" do
    get embarque_index_url
    assert_response :success
  end

  test "should get new" do
    get embarque_new_url
    assert_response :success
  end

end
