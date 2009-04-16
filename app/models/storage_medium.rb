class StorageMedium < ActiveRecord::Base
  extend Exportables::ExportableModel

  def to_label
    self.storage_medium
  end
end
