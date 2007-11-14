class CreateGenders < ActiveRecord::Migration
  def self.up
    create_table :genders do |t|
      t.column :sample_id, :integer
      t.column :project_id, :integer
      t.column :gender, :string
      t.column :gelNum, :string
      t.column :wellNum, :string
      t.column :finalResult, :boolean
    end
  end

  def self.down
    drop_table :genders
  end
end
