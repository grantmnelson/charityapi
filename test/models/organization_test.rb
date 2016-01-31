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

  test "EIN is exactly 9 digits" do

    @org = organizations(:oakleaf)
    @org.ein = "123" # too short
    assert_not @org.valid?

    @org = organizations(:oakleaf)
    @org.ein = "1234567890" # too long
    assert_not @org.valid?
  end

  test "State code has length 2 if it is in US" do
    @org = organizations(:oakleaf)
    if @org.country=="United States"
      assert @org.state.code.length == 2
    end
  end

  test "deductibility status is not nil" do
    @org = organizations(:oakleaf)
    @org.status = nil
    assert_not @org.valid?
  end

  test "deductibility status is a valid one" do
    @org = organizations(:oakleaf)
    @org.status = "WRONG"
    assert_not @org.valid?
  end

  test "deductibility status is valid when valid" do
    @org = organizations(:oakleaf)
    assert @org.valid? unless @org.status
  end

end
