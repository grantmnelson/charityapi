class Postcard < ActiveRecord::Base
  belongs_to :officer_address_state, :class_name => 'State'
  belongs_to :organization_address_state, :class_name => 'State'
  belongs_to :organization

  # Before validation


  # Validation
  validates :ein, presence: true
  validates :tax_year, presence: true
  validates :organization_name, presence: true
  validates :gross_receipts_under_25k, :inclusion => {:in => [true, false]} # 'T' represents True and 'F' represents False.
  validates :terminated, :inclusion => {:in => [true, false]}
  validates :tax_period_begin_date, presence: true # Required, Format: MM-DD-YYYY
  validates :tax_period_end_date, presence: true # Required, Format: MM-DD-YYYY
  # validates :officer_name, presence: true # Evidently officers are not required despite what the IRS says
  validates :officer_address_line_1, presence: true
  validates :officer_address_city, presence: true, if: Proc.new { |a| a.officer_address_country == "US" }
  # Officer Address Province, Optional if country is not US. Null if country is US
  validates :officer_address_state_id, presence: true, if: Proc.new { |a| a.officer_address_country == "US" }
  validates :officer_address_postal_code, presence: true, if: Proc.new { |a| a.officer_address_country == "US" }
  validates :officer_address_country, presence: true
  validates :organization_address_line_1, presence: true
  validates :organization_address_city, presence: true, if: Proc.new { |a| a.officer_address_country == "US" }
  # Organization Address Province, Optional if country is not US. Null if country is US
  validates :organization_address_state_id, presence: true, if: Proc.new { |a| a.officer_address_country == "US" }
  validates :organization_address_postal_code, presence: true, if: Proc.new { |a| a.officer_address_country == "US" }
  validates :organization_address_country, presence: true

  def self.parse_postcard_data(filepath)
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
            if (row_hash[:officer_address_country] == "US" || row_hash[:officer_address_country].nil?)
              row_hash[:officer_address_state_id] = State.find_by_code(row_hash[:officer_address_state_id]).id
              row_hash[:organization_address_state_id] = State.find_by_code(row_hash[:organization_address_state_id]).id
            end

            postcard = Postcard.find_or_initialize_by(ein: row_hash[:ein])
            postcard.attributes = row_hash
            puts postcard.inspect unless postcard.valid?
            puts postcard.errors
            postcard.save!

          end
    end

  end


  # This method checks if the field has a corresponding field_last_checked
  def log_changed
   self.attribute_names.each do |attribute_name|
     if self.changes.include?(attribute_name) && Organization.column_names.include?("#{attribute_name}_last_changed")
       self.update_attribute("#{attribute_name}_last_changed", Time.now)
     end
   end
  end
end
