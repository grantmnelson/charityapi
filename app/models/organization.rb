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
    # Doesn't seem like this is being used. Is that intentional?
   n = SmarterCSV.process(filepath, options) do |array|
     array.each do |row_hash|
       next if row_hash[:ein].nil? # Skip if the row or hash is empty.
       row_hash[:state_id] = State.find_by_code(row_hash[:state_id]).id if row_hash[:country] == "US"
       o = Organization.find_or_initialize_by(ein: row_hash[:ein])
       o.attributes = row_hash
       o.save!
     end
   end
 end

 def self.parse_bmf_data(filepath)
   options = { :col_sep => ",",
               :chunk_size => 100,
               :convert_values_to_numeric => false,
               :remove_empty_values => false,
               :remove_zero_values => false,
               :verbose => true,
               :headers_in_file => true,
               :remove_unmapped_keys => true,
               :key_mapping => {
                 :EIN=>:ein,
                 :ZIP=>:zip,
                 :SUBSECTION=>:irs_code_subsection,
                 :AFFILIATION=>:affiliation_code,
                 :RULING=>:ruling_date,
                 :DEDUCTIBILITY=> :deductibility_code,
                 :FOUNDATION=>:foundation_code_specific,
                 :ACTIVITY=>:activity_code,
                 :ORGANIZATION=>:organization_code,
                 :TAX_PERIOD=>:last_return,
                 :ASSET_CD=>:asset_code,
                 :INCOME_CD=>:income_code,
                 :FILING_REQ_CD=>:filing_requirement,
                 :PF_FILING_REQ_CD=>:pf_return_requirement,
                 :ACCT_PD=>:accounting_end,
                 :ASSET_AMT=>:asset_amount,
                 :INCOME_AMT=>:income_amount,
                 :REVENUE_AMT=>:revenue_990,
                 :NTEE_CD=>:ntee,
                 :CLASSIFICATION=>:classification_code_1
               }
   }

   n = SmarterCSV.process(filepath,options) do |array|
     array.each do |row_hash|
       puts row_hash
       next if row_hash[:ein].nil? #skip if the row or hash is empty
       next if row_hash[:ein] == "EIN" #skip if the row or hash is a header (this is redundant)
       row_hash[:classification_code_4] = row_hash[:classification_code_1][3]
       row_hash[:classification_code_3] = row_hash[:classification_code_1][2]
       row_hash[:classification_code_2] = row_hash[:classification_code_1][1]
       row_hash[:classification_code_1] = row_hash[:classification_code_1][0]

       row_hash[:ntee_category]= row_hash[:ntee][0]

       org_current = Organization.find_or_initialize_by(ein: row_hash[:ein])
       org_new = Organization.new(row_hash)
       org_combined = non_destructive_merge(org_current, org_new)
       org_combined.save!

     end
   end
 end

 def self.parse_revoked_data(filepath)
   options = { :col_sep => "|",
               :chunk_size => 100,
               :convert_values_to_numeric => false,
               :remove_empty_values => false,
               :remove_zero_values => false,
               :verbose => true,
               :headers_in_file => false,
               :user_provided_headers => [
                                         "ein",
                                         "legal_name",
                                         "doing_business_as_name",
                                         "organization_address",
                                         "city",
                                         "state_id",
                                         "zip",
                                         "country",
                                         "exemption_type",
                                         "revocation_date",
                                         "revocation_posting_date"
                                       ]
                }

        n = SmarterCSV.process(filepath, options) do |array|
          array.each do |row_hash|
            next if row_hash[:ein].nil? # Skip if the row or hash is empty.
            row_hash[:state_id] = State.find_by_code(row_hash[:state_id]).id if row_hash[:country] == "US"
            row_hash[:revocation_date] = Date.parse(row_hash[:revocation_date])
            row_hash[:revocation_posting_date] = Date.parse(row_hash[:revocation_posting_date])
            r = Revokedorganization.find_or_initialize_by(ein: row_hash[:ein])
            r.attributes = row_hash
            r.save!

          end
        end


 end

 private
    # combines two objects with the same attributes, does not overwrite anything with nil,
    # making it non-destructive. Returns original object with new combined attributes.
   def non_destructive_merge(old_obj, new_obj)
     @new_attrs = new_obj.attributes.reject { |k, v| v.nil? }
     @new_attrs.reject! { |k, v| v.blank? }
     old_obj.attributes = @new_attrs
     old_obj
   end

end
