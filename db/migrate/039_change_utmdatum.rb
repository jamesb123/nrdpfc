class ChangeUtmdatum < ActiveRecord::Migration
  def self.up
      change_column :samples, :UTM_datum, :string    
  end

  def self.down
      change_column :samples, :UTM_datum, :float
  end
end
