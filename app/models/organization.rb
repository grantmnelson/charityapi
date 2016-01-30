class Organization < ActiveRecord::Base
  belongs_to :state

  # Before validation


  # Validation
  validates :ein, presence: true
  validates :state, presence: true
  validate :format_ein_number, if: Proc.new { |a| a.ein }
  validate :validate_ein_length, if: Proc.new { |a| a.ein }
  validate :validate_ein_prefix, if: Proc.new { |a| a.ein }

  def format_ein_number # is this method neccessary for us?
    self.ein = self.ein.gsub(/\D/, '')
  end

 # Validates that the ein entered by the user has a known valid prefix.
 def validate_ein_prefix
   # Data from https://www.irs.gov/Businesses/Small-Businesses-&-Self-Employed/How-EINs-are-Assigned-and-Valid-EIN-Prefixes
   #  Note - these acceptable_prefixes include prefixes that the IRS doesn't include on their database of valid prefixes
   # but actually assigns in practice (according to IRS data dumps)
   acceptable_prefixes = [
    "00", "01", "02", "03", "04", "05", "06", 10, 12, 60, 67, 50, 53, 11, 13, 14, 16, 21, 22, 23,
    25, 34, 51, 52, 54, 55, 56, 57, 58, 59, 65, 30, 32, 35, 36, 37, 38, 61, 15,
    24, 40, 44, 94, 95, 80, 90, 33, 39, 41, 42, 43, 48, 62, 63, 64, 66, 68, 71,
    72, 73, 74, 75, 76, 77, 81, 82, 83, 84, 85, 86, 87, 88, 91, 92, 93, 98, 99,
    20, 26, 27, 45, 46, 47, 31
   ]

   acceptable_prefixes.map! { |p| p.to_s }

   if !acceptable_prefixes.include?(self.ein[0,2])
     errors.add(:ein, "First Two Digits of EIN are invalid")
   end

 end

 def validate_ein_length
   if self.ein.to_s.length != 9
     errors.add(:ein, "EIN Number Should be 9 Digits")
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
