class Organization < ActiveRecord::Base

  belongs_to :state

  # Before validation


  # Validation
  validates :ein, presence: true, ein: true
  validates :state, presence: true, if: Proc.new {|a| a.country == "US"}
  validates :status, presence: true
  validate :validates_deductibility_code, if: Proc.new {|a| a.status}

  def validates_deductibility_code
    acceptable_codes = [
      "PC", "POF", "PF", "GROUP", "LODGE", "UNKWN", "EO", "FORGN", "SO",
      "SONFI", "SOUNK"
    ]

    # Organization status can include multiple codes
    organization_codes = self.status.split(",")

    if (acceptable_codes & organization_codes).empty?
      errors.add(:status, "Not a valid deductibility status description")
    end

  end

  def format_ein_number # is this method neccessary for us?
    self.ein = self.ein.gsub(/\D/, '')
  end

 # This method checks if the field has a corresponding field_last_checked
 def log_changed
  self.attribute_names.each do |attribute_name|
    if self.changes.include?(attribute_name) && Organization.column_names.include?("#{attribute_name}_last_changed")
      self.update_attribute("#{attribute_name}_last_changed", Time.now)
    end
  end
 end

 def self.parse_organization_data(filepath)
   options = { :col_sep => "|",
               :chunk_size => 100,
               :headers_in_file => false,
               :convert_values_to_numeric => false,
               :remove_empty_values => false,
               :remove_zero_values => false,
               :verbose => true,
               :user_provided_headers => [
                                         "ein",
                                         "legal_name",
                                         "city",
                                         "state_id",
                                         "country",
                                         "status"
                                       ]


             }
   n = SmarterCSV.process(filepath, options) do |array|
         array.each do |row_hash|
           next if row_hash[:ein].nil? # Skip if the row or hash is empty.
           row_hash[:state_id] = State.find_by_code(row_hash[:state_id]) if row_hash[:country] == "US"

           o = Organization.find_or_initialize_by(ein: row_hash[:ein])
           o.attributes = row_hash
           puts o.attributes
           puts "INVALID" unless o.valid?
           puts "ERRORS:" unless o.valid?
           puts o.errors.inspect unless o.valid?
           o.save!

         end
   end

 end

end
