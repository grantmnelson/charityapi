class Postcard < ActiveRecord::Base
  belongs_to :officer_address_state, :class_name => 'State'
  belongs_to :organization_address_state, :class_name => 'State'
  belongs_to :organization

  # Before validation


  # Validation
  validates :ein, presence: true
  validates :tax_year, presence: true
  validates :organization_name, presence: true
  validates :gross_reciepts_under_25k, :inclusion => {:in => [true, false]} # 'T' represents True and 'F' represents False.
  validates :terminated, :inclusion => {:in => [true, false]}
  validates :tax_period_begin_date, presence: true # Required, Format: MM-DD-YYYY
  validates :tax_period_end_date, presence: true # Required, Format: MM-DD-YYYY
  validates :officer_name, presence: true
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



  # This method checks if the field has a corresponding field_last_checked
  def log_changed
   self.attribute_names.each do |attribute_name|
     if self.changes.include?(attribute_name) && Organization.column_names.include?("#{attribute_name}_last_changed")
       self.update_attribute("#{attribute_name}_last_changed", Time.now)
     end
   end
  end
end
