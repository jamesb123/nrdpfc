class CreateOrganisms < ActiveRecord::Migration
# has dynamic attributes
  def self.up
    create_table :organisms do |t|
      t.column :project_id, :integer
      t.column :organism_code, :string     
      t.column :comment, :string    
    end
  end

  def self.down
    drop_table :organisms
  end
end
