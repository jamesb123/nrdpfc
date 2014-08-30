class CreateSnpsTable < ActiveRecord::Migration
  def self.up
    create_table :snps do |t|
      t.column :project_id, :integer
      t.column :sample_id, :integer
      t.column :plate, :string
      t.column :well, :string
      t.column :locus, :string
      t.column :allele1, :string
      t.column :allele2, :string
      t.column :date_genotyped, :date
      t.column :comments, :string
      t.column :locu_id, :integer
      t.timestamps
    end
  end

  def self.down
    drop_table :snps
  end
end
