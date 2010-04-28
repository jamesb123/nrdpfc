class StorageMedium < ActiveRecord::Base
  has_many :samples

  def to_label
    self.storage_medium
  end
end
