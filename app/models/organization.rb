class Organization < ActiveRecord::Base
  belongs_to :state

  # Before validation
  before_validate :format_ein_number

  # Validation
  validates :ein, presence: true
  validate :validate_ein_length
  validate :validate_ein_prefix








  def format_ein_number # is this method neccessary for us?
    self.ein = self.ein.gsub(/\D/, '') unless self.tax_id_number.nil? # Removes all non-digits from the EIN number.
  end

 # Validates that the tax_id_number entered by the user has a known valid prefix.
 def validate_ein_prefix
   # Data from https://www.irs.gov/Businesses/Small-Businesses-&-Self-Employed/How-EINs-are-Assigned-and-Valid-EIN-Prefixes
   acceptable_prefixes = [
    10, 12, 60, 67, 50, 53, 01, 02, 03, 04, 05, 06, 11, 13, 14, 16, 21, 22, 23,
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
   self.ein.gsub!(/\D/, '') # what does this line do?
   if self.ein.length != 9
     errors.add(:ein, "EIN Number Should be 9 Digits")
   end
 end

end
