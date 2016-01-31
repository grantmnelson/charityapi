class State < ActiveRecord::Base
  has_many :organizations
  has_many :officer_address_states, :class_name => 'Postcard', :foreign_key => 'officer_address_states_id'
  has_many :organization_address_states, :class_name => 'Postcard', :foreign_key => 'organization_address_states_id'
end
