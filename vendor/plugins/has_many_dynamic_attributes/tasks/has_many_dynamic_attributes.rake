require "#{RAILS_ROOT}/config/environment"

class DynamicType < ActiveRecord::Base; end;
class DynamicClass < ActiveRecord::Base; end;

namespace :has_many_dynamic_attributes do
  namespace :migrate do   
    # ---------------------------------------------------------------------
    # Create has_many_dynamic_attributes tables and pre-populate
    desc 'Create the database tables needed for the has_many_dynamic_attributes plugin.'
    task :up => :environment do

      # Create the dynamic_types table if it doesn't exist
      unless ActiveRecord::Schema.tables.include?('dynamic_types')
        ActiveRecord::Schema.create_table('dynamic_types') do |t|
          t.column :name,            :string
          t.column :stored_in_field, :string
          t.column :description,     :string
        end
        DynamicType.reset_column_information

        ActiveRecord::Schema.add_index( 'dynamic_types', 'name' )
        
        # Create some default features
        DynamicType.create(:name => 'integer', :stored_in_field => 'integer_value', :description => 'Integers')
        DynamicType.create(:name => 'decimal', :stored_in_field => 'float_value', :description => 'Floating Points')
        DynamicType.create(:name => 'text', :stored_in_field => 'text_value', :description => 'Text')
        DynamicType.create(:name => 'date', :stored_in_field => 'date_value', :description => 'Dates')
        DynamicType.create(:name => 'timestamp', :stored_in_field => 'timestamp_value', :description => 'Timestamps')
      end

      # Create the dynamic_classes table if it doesn't exist
      unless ActiveRecord::Schema.tables.include?('dynamic_classes')
        ActiveRecord::Schema.create_table('dynamic_classes') do |t|
          t.column :name, :string
        end
        DynamicClass.reset_column_information
        
        ActiveRecord::Schema.add_index( 'dynamic_classes', 'name' )
        
        # Create some default classes
        DynamicClass.create(:name => 'weight')
        DynamicClass.create(:name => 'height')
      end

      # Create the dynamic_attributes table if it doesn't exist
      unless ActiveRecord::Schema.tables.include?('dynamic_attributes')
        ActiveRecord::Schema.create_table('dynamic_attributes') do |t|
          t.column :name,                   :string
          t.column :dynamic_type_id,        :integer
          t.column :dynamic_class_id,       :integer
          t.column :scoper_type,            :string
          t.column :scoper_id,              :integer
          t.column :owner_type,             :string
        end
        ActiveRecord::Schema.add_index( 'dynamic_attributes', 'name' )
        ActiveRecord::Schema.add_index( 'dynamic_attributes', 'dynamic_type_id' )
        ActiveRecord::Schema.add_index( 'dynamic_attributes', 'dynamic_class_id' )
        ActiveRecord::Schema.add_index( 'dynamic_attributes', 'owner_type' )
      end

      # Create the dynamic_attribute_values table if it doesn't exist
      unless ActiveRecord::Schema.tables.include?('dynamic_attribute_values')
        ActiveRecord::Schema.create_table('dynamic_attribute_values') do |t|
          t.column :dynamic_attribute_id,   :integer
          t.column :owner_type,             :string
          t.column :owner_id,               :integer
          t.column :integer_value,          :integer    
          t.column :float_value,            :decimal
          t.column :text_value,             :text
          t.column :date_value,             :date
          t.column :timestamp_value,        :timestamp
        end
        ActiveRecord::Schema.add_index( 'dynamic_attribute_values', 'dynamic_attribute_id' )
        ActiveRecord::Schema.add_index( 'dynamic_attribute_values', 'owner_id' )
        ActiveRecord::Schema.add_index( 'dynamic_attribute_values', 'owner_type' )
        ActiveRecord::Schema.add_index( 'dynamic_attribute_values', ['owner_type','owner_id'] )
      end

    end
                                                     
    # -------------------------------------------------------------------------
    # Destroys has_many_dynamic_attributes persistence tables
    desc 'Drop the database tables needed for the has_many_dynamic_attributes plugin.'
    task :down => :environment do
      # Delete the dynamic_types table
      if ActiveRecord::Schema.tables.include?('dynamic_types')
        ActiveRecord::Schema.remove_index( 'dynamic_types', 'name' )
        ActiveRecord::Schema.drop_table('dynamic_types')
      end

      # Delete the dynamic_classes table
      if ActiveRecord::Schema.tables.include?('dynamic_classes')
        ActiveRecord::Schema.remove_index( 'dynamic_classes', 'name' )       
        ActiveRecord::Schema.drop_table('dynamic_classes')
      end
      
      # Delete the dynamic_attributes table
      if ActiveRecord::Schema.tables.include?('dynamic_attributes')
        ActiveRecord::Schema.remove_index( 'dynamic_attributes', 'name' )
        ActiveRecord::Schema.remove_index( 'dynamic_attributes', 'dynamic_type_id' )
        ActiveRecord::Schema.remove_index( 'dynamic_attributes', 'dynamic_class_id' )
        ActiveRecord::Schema.remove_index( 'dynamic_attributes', 'owner_id' )
        ActiveRecord::Schema.remove_index( 'dynamic_attributes', 'owner_type' )
        ActiveRecord::Schema.remove_index( 'dynamic_attributes', ['owner_type','owner_id'] )
        ActiveRecord::Schema.drop_table('dynamic_attributes')
      end
      
      # Delete the dynamic_attribute_values table
      if ActiveRecord::Schema.tables.include?('dynamic_attribute_values')
        ActiveRecord::Schema.remove_index( 'dynamic_attribute_values', 'dynamic_attribute_id' )
        ActiveRecord::Schema.remove_index( 'dynamic_attribute_values', 'owner_id' )
        ActiveRecord::Schema.remove_index( 'dynamic_attribute_values', 'owner_type' )
        ActiveRecord::Schema.remove_index( 'dynamic_attribute_values', ['owner_type','owner_id'] )
        
        ActiveRecord::Schema.drop_table('dynamic_attribute_values')
      end
    end
  end
                                      
end