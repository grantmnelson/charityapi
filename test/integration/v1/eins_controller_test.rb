require 'test_helper'

class ApiTestV1 < ActionDispatch::IntegrationTest
  setup do

  end

  test "returns X" do
    get("/1/eins/000003154")
    assert_response :success
    puts response.body
  end


end
