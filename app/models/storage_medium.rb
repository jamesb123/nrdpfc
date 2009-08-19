class StorageMedium < ActiveRecord::Base
  extend Exportables::ExportableModel

  has_many :samples

  def to_label
    self.storage_medium
  end
end
