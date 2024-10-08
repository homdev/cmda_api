require "test_helper"

class Api::V1::PasswordsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get api_v1_passwords_create_url
    assert_response :success
  end

  test "should get update" do
    get api_v1_passwords_update_url
    assert_response :success
  end
end
