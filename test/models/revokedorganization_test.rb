require 'test_helper'

class RevokedorganizationTest < ActiveSupport::TestCase
  
  test "fixtures are valid" do
    Revokedorganization.find_each do |o| 
      assert o.valid?
    end
  end
  
  def setup
    @org = revokedorganizations(:oakleaves)
  end
  
  test "EIN is required" do
    @org.ein = ""
    assert_not @org.valid?
  end
  
  test "EIN cannot be nil" do
    @org.ein = nil
    assert_not @org.valid?
  end
  
  # Not sure what else to test here

end
