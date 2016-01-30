class Postcard < ActiveRecord::Base
  belongs_to :officer_address_state, :class_name => 'State'
  belongs_to :organization_address_state, :class_name => 'State'
  belongs_to :organization
end
