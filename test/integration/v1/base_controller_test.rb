require 'test_helper'

class V1::BaseControllerTest < ActionDispatch::IntegrationTest
  # Replace this with your real tests.
  test "the truth" do
    get('/eins', {ein: "000003154"}, {'Accept' => 'application/json'})
    
  end
end
