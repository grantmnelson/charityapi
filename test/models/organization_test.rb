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

  test "All Organizations have an EIN" do
    @org = organizations(:oakleaf)
    @org.ein = ""
    assert_not @org.valid?
  end

  test "EIN cannot be nil" do
    @org = organizations(:oakleaf)
    @org.ein = nil
    assert_not @org.valid?
  end

  test "All Orgs have a state" do
    @org = organizations(:oakleaf)
    @org.state_id = nil
    assert_not @org.valid?
  end

  test "EIN is exactly 9 digits" do

    @org = organizations(:oakleaf)
    @org.ein = "123" # too short
    assert_not @org.valid?

    @org = organizations(:oakleaf)
    @org.ein = "1234567890" # too long
    assert_not @org.valid?
  end



end
