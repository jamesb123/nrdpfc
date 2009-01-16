class Role < ActiveRecord::Base
  has_many :addresses
  include SecuritySets::AdminOnly

  def to_label
    "#{short_role}"
  end
end
