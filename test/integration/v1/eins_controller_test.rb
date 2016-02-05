require 'test_helper'

class V1::EinsControllerTest < ActionDispatch::IntegrationTest
  # Replace this with your real tests.
  test "should get v1" do
  get '/eins', {ein: "000003154"}, {'Accept' => 'application/json', 'version' => '1'}
    assert_response 200
  end

end
