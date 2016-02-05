require 'test_helper'

class APIV1EinsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @version = 1
    @controller_route = "eins"
  end

  test "returns Data about Oakleaf" do
    get("/#{@version}/#{@controller_route}/000003154")
    @response = JSON.parse(response.body)["response"]
    assert @response[:ein] = "000003154", "#{@response[:ein]}"
  end




  # Test Error States
  test "returns nil if not found" do
    get("/#{@version}/#{@controller_route}/no_value_should_return_nothing")
    assert_response :success
    assert JSON.parse(response.body)[:response] = "null"
  end

end
