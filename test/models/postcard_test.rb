require 'test_helper'

class PostcardTest < ActiveSupport::TestCase

  test "fixtures are valid" do
    Postcard.find_each do |o|
      assert o.valid?
    end
  end

  def setup
    @org = postcards(:dawson)
  end


  test "tax_year is present" do
      assert @org.tax_year
      @org.tax_year = nil
      assert_not @org.tax_year
  end

  test "organization_name is present" do
    assert @org.organization_name
  end
  # is this one below right?
  test "gross_reciepts_under_25k is not nil (boolean)" do
    if @org.gross_reciepts_under_25k
      assert @org.gross_reciepts_under_25k
    end
  end

  test "Terminated is not nil" do
    assert_not @org.terminated.nil?
  end

  test "tax period begin date is present" do
    assert @org.tax_period_begin_date
  end

  test "tax period end date is present" do
    assert @org.tax_period_end_date
  end

  test "officer name is present" do
    assert_not @org.officer_name.nil?
  end

  test "officer address line 1 is present" do
    assert_not @org.officer_address_line_1.nil?
  end

  test "officer address city is present if country is US" do
    assert_not @org.officer_address_city.nil?
  end

  test "officer province address is nil if country is US" do
    assert @org.officer_address_province.nil? if @org.officer_address_country == "US"
  end

  test "officer zip code present if country is US" do
    assert @org.officer_address_postal_code if @org.officer_address_country == "US"
  end

  test "Officer country is present" do
    assert @org.officer_address_country
  end

  test "organization address line 1 is present" do
    assert @org.organization_address_line_1
  end

  test "organization city is present if organization is in US" do
    assert @org.organization_address_city if @org.organization_address_country == "US"
  end

  test "Organization address province is nil if country is not US" do
    assert @org.organization_address_province.nil? if @org.organization_address_country != "US"
  end

  test "Organization state address is required if in the US" do
    assert @org.organization_address_line_1 if @org.organization_address_country == "US"
  end

  test "Organization zip code required if in the US" do
    assert @org.organization_address_postal_code if @org.organization_address_country == "US"
  end

  test "Organization country is required" do
    assert @org.organization_address_country
  end

  test "Post Card belongs to an organization" do
    # test that organization_id is a number
    assert @org.organization_id.class == Fixnum
  end


end
