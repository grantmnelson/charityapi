class RevokedOrganization < ActiveRecord::Base
  belongs_to :state
  belongs_to :organization
end
