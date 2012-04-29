class CreateSsamples < ActiveRecord::Migration
  def self.up
    create_table :ssamples do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :ssamples
  end
end
