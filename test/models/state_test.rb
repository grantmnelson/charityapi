require 'test_helper'

class StateTest < ActiveSupport::TestCase
  
  test "fixtures are valid" do
    State.find_each do |o|
      assert o.valid?
    end
  end
  
  
end
