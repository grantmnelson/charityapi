require 'test_helper'

class PostcardTest < ActiveSupport::TestCase

  test "fixtures are valid" do
    Postcard.find_each do |o|
      assert o.valid?
    end
  end

  test "tax_year is present" do

  end

  test "organization_name is present" do

  end

  test "gross_reciepts_under_25k is not nil (boolean)" do

  end

  test "Terminated is not nil" do

  end

  test "tax period begin date is present" do

  end

  test "tax period end date is present" do

  end

  test "officer name is present" do

  end

  test "officer address line 1 is present" do

  end

  test "officer address city is present if country is US" do

  end

  test "officer province address is nil if country is US" do

  end

  test "officer zip code present if country is US" do

  end

  test "Officer country is present" do

  end

  test "organization address line 1 is present" do

  end

  test "organization city is present if organization is in US" do

  end

  test "Organization address province is nil if country is not US" do

  end

  test "Organization state address is required if in the US" do

  end

  test "Organization zip code required if in the US" do

  end

  test "Organization country is required" do

  end

  test "Post Card belongs to an organization" do
    # test that organization_id is a number
  end


end
