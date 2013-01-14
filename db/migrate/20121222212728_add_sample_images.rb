class AddSampleImages < ActiveRecord::Migration
  def self.up
    add_column :samples, :sample_image1, :string
  end

  def self.down
    remove_column :samples, :sample_image1
  end
end
