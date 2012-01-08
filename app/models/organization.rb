class Organization < ActiveRecord::Base
has_many :samples
def to_s
  "#{self.org_name}"
end
end
