class Organization < ActiveRecord::Base

  belongs_to :state

  # Before validation


  # Validation
  validates :ein, presence: true, ein: true
  validates :state, presence: true
  validates :status, presence: true
  validate :validates_deductibility_code, if: Proc.new {|a| a.status}

  def validates_deductibility_code
    acceptable_codes = [
      "PC", "POF", "PF", "GROUP", "LODGE", "UNKWN", "EO", "FORGN", "SO",
      "SONFI", "SOUNK"
    ]

    if !acceptable_codes.include?(self.status)
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

end
