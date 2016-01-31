require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "fixtures are valid" do
    User.find_each do |o|
      assert o.valid?
    end
  end
end
