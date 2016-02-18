class Revokedorganization < ActiveRecord::Base
  belongs_to :state
  belongs_to :organization

  # This method checks if the field has a corresponding field_last_checked
  def log_changed
   self.attribute_names.each do |attribute_name|
     if self.changes.include?(attribute_name) && Organization.column_names.include?("#{attribute_name}_last_changed")
       self.update_attribute("#{attribute_name}_last_changed", Time.now)
     end
   end
  end
end 
