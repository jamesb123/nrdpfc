class CreateSnps < ActiveRecord::Migration
  def self.up
    create_table :snps do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :snps
  end
end
