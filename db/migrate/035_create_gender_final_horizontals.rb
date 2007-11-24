class CreateGenderFinalHorizontals < ActiveRecord::Migration
  def self.up
    create_table :gender_final_horizontals do |t|
      t.integer :project_id
      t.integer :organism_id
      t.integer :organism_code
      t.integer :gender
      t.timestamps
    end
  end

  def self.down
    drop_table :gender_final_horizontals
  end
end
