class Address < ActiveRecord::Base
  belongs_to :user
  belongs_to :role
  include SecuritySets::AdminOnly
end
