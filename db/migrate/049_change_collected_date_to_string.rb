class ChangeCollectedDateToString < ActiveRecord::Migration
  
  def self.up
    change_column :samples, :collected_on_day, :string
    change_column :samples, :collected_on_month, :string
    change_column :samples, :collected_on_year, :string
  end

  def self.down
    change_column :samples, :collected_on_day, :integer
    change_column :samples, :collected_on_month, :integer
    change_column :samples, :collected_on_year, :integer
  end

end
