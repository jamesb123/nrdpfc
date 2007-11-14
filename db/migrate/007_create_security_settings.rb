class CreateSecuritySettings < ActiveRecord::Migration
  def self.up
    create_table :security_settings do |t|
      t.column :project_id, :integer
      t.column :user_id, :integer
      t.column :level, :integer, :default => 0
    end
    
    add_index :security_settings, :project_id  
    add_index :security_settings, :user_id  
  end

  def self.down
    drop_table :security_settings
  end
end
