class ParsePostcardDataWorker
  include Sidekiq::Worker

  # The perform() method is called regularly to collect and combine the data that
  # the IRS publishes in the ePostcard file online.

  # Do Not rename the method from perform. You can define more methods below.
  def perform(filepath)

    options = { :col_sep => "|",
                :chunk_size => 100,
                :headers_in_file => false,
                :convert_values_to_numeric => false,
                :remove_empty_values => false,
                :remove_zero_values => false,
                :verbose => true,
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
    n = SmarterCSV.process(filepath, options) do |array|
          array.each do |row_hash|
            next if row_hash[:ein].nil? # Skip if the row or hash is empty.
            row_hash[:gross_receipts_under_25k] = row_hash[:gross_receipts_under_25k] == 'T' ? true : false
            row_hash[:terminated] = row_hash[:terminated] == 'T' ? true : false
            row_hash[:tax_period_begin_date] = DateTime.strptime(row_hash[:tax_period_begin_date], '%m-%d-%Y')
            row_hash[:tax_period_end_date] = DateTime.strptime(row_hash[:tax_period_end_date], '%m-%d-%Y')
            row_hash[:officer_address_state_id] = State.find_by_code(row_hash[:officer_address_state_id]) if row_hash[:officer_address_country] == "US"
            row_hash[:organization_address_state_id] = State.find_by_code(row_hash[:organization_address_state_id]) if row_hash[:organization_address_country] == "US"


            Postcard.create(row_hash)

          end
    end

  end

end
