class ChangeAllDatetimeToDate < ActiveRecord::Migration
  def self.up
    change_column :mt_dnas, :date_sequenced, :date
    change_column :dna_results, :extraction_date, :date

    change_column :samples, :date_collected, :date
    change_column :samples, :date_received, :date
    change_column :samples, :date_submitted, :date
    change_column :samples, :profiling_date, :date
    change_column :samples, :extraction_date, :date
    change_column :samples, :shipping_date, :date
    
    change_column :genders, :date_genotyped, :date
    change_column :microsatellites, :date_genotyped, :date
    
  end

  def self.down
    change_column :mt_dnas, :date_sequenced, :datetime
    change_column :dna_results, :extraction_date, :datetime

    change_column :samples, :datetime_collected, :datetime
    change_column :samples, :datetime_received, :datetime
    change_column :samples, :datetime_submitted, :datetime
    change_column :samples, :profiling_date, :datetime
    change_column :samples, :extraction_date, :datetime
    change_column :samples, :shipping_date, :datetime
    
    change_column :genders, :datetime_genotyped, :datetime
    change_column :microsatellites, :datetime_genotyped, :datetime
  end
end
