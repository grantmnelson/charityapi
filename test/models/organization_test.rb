require 'test_helper'

class OrganizationTest < ActiveSupport::TestCase
  test "the truth" do
    assert true
  end

  test "fixtures are valid" do
    Organization.find_each do |o|
      assert o.valid?
    end
  end
end
