require 'test_helper'

class ParsePostcardDataWorkerTest < ActiveSupport::TestCase

  def setup

  end

  test "Test that the data was parsed" do
    Sidekiq::Testing.inline!


    filename = 'test/files/postcard_test.txt'
    options = { :col_sep => "|",
                :chunk_size => 100,
                :headers_in_file => false,
                :convert_values_to_numeric => false,
                :user_provided_headers => [
                                          "ein",
                                          "tax_year",
                                          "organization_name",
                                          "gross_receipts_under_25k",
                                          "terminated",
                                          "tax_period_begin_date",
                                          "tax_period_end_date",
                                          "website_url",
                                          "officer_name",
                                          "officer_address_line_1",
                                          "officer_address_line_2",
                                          "officer_address_city",
                                          "officer_address_province",
                                          "officer_address_state_id",
                                          "officer_address_postal_code",
                                          "officer_address_country",
                                          "organization_address_line_1",
                                          "organization_address_line_2",
                                          "organization_address_city",
                                          "organization_address_province",
                                          "organization_address_state_id",
                                          "organization_address_postal_code",
                                          "organization_address_country",
                                          "doing_business_as_name_1",
                                          "doing_business_as_name_2",
                                          "doing_business_as_name_3",
                                        ]


              }
    n = SmarterCSV.process(filename, options) do |array|
          # we're passing a block in, to process each resulting hash / =row (the block takes array of hashes)
          # when chunking is not enabled, there is only one hash in each array

          # Convert values in the CSV to the format the database expects.
          array.each do |row_hash|
            puts row_hash[:ein]
            puts DateTime.parse("2011-05-19 10:30:14").strftime('%Q')

          end
    end

  end

end
