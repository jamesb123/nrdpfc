class Address < ActiveRecord::Base
  belongs_to :user

  include SecuritySets::AdminOnly

end
