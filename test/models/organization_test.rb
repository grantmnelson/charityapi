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
   
  def setup
    @org = organizations(:oakleaf) 
  end
  
  # If I add numbers to this the test still passes. Why is that?
  test "All Organizations have an EIN" do
    @org.ein = ""
    assert_not @org.valid?
  end

  test "EIN cannot be nil" do
    @org.ein = nil
    assert_not @org.valid?
  end

  test "EIN is exactly 9 digits" do
    @org.ein = "123" # too short
    assert_not @org.valid?

    @org.ein = "1234567890" # too long
    assert_not @org.valid?
  end

  test "State code has length 2 if it is in US" do
    if @org.country=="United States"
      assert @org.state.code.length == 2
    end
  end

  test "deductibility status is not nil" do
    @org.status = nil
    assert_not @org.valid?
  end

  test "deductibility status is a valid one" do
    @org.status = "WRONG"
    assert_not @org.valid?
  end

  test "deductibility status is valid when valid" do
    assert @org.valid? unless @org.status
  end

  test "organizations with multiple statuses are still allowed" do
    @org.status = "EO,FAKE,FAKE"
    assert @org.valid?
  end

end
