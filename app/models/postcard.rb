class Postcard < ActiveRecord::Base
  has_many :states
  belongs_to :organization
end
