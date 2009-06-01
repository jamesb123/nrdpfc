module Exportables::DynamicAttributesExportableModel
  include Exportables::ExportableModel
  
  def self.extended(klass)
    Exportables::ExportableModel.extended(klass)
  end
  
  def exportable_fields
    non_dynamic_fields + dynamic_attribute_fields
  end
  
  def non_dynamic_fields
    self.columns.map(&:name)
  end
  
  def dynamic_attribute_fields
    dynamic_attributes.map(&:name)
  end
  
  # returns an array of strings
  def dynamic_attributes
    if current_project
      @dynamic_attributes = nil unless @project_id == current_project_id
      @project_id = current_project_id
      @dynamic_attributes ||= DynamicAttribute.find(:all, :conditions => {:scoper_type => "Project", :scoper_id => current_project_id, :owner_type => self.to_s}, :order => "name" )
    else
      []
    end
  end
  
  def exportable_filter(field, operator, operand)
    return super if non_dynamic_fields.include?(field.to_s)

    qp = QueryPiece.new
    return(qp) if operator.strip.blank?

    field_name = "#{table_name}_#{field}"
    data = exportable_field_sql(field_name, operator, operand)

    qp.having << Where(*data).to_s
    qp
  end
  
  alias :exportable_column_types_hash_super :exportable_column_types_hash
  def exportable_column_types_hash
    exportable_column_types_hash_super.merge(dynamic_types_hash)
  end
  
  alias :exportable_select_super :exportable_select
  def exportable_select(column_name)
    column_name = column_name.to_s
    if dynamic_attributes_names.include?(column_name)
      QueryPiece.new(
        :select => dynamic_attribute_select_statement(column_name),
        :join =>   dynamic_attribute_join_statement(column_name)
      )
    else
      exportable_select_super(column_name)
    end
  end
  
  alias :exportable_from_super :exportable_from
  def exportable_from(options = {})
    exportable_from_super(options) + QueryPiece.new(:join => dynamic_attributes_joins)
  end
  
  #
  ##
  ###
  protected
    def dynamic_attribute_join_statement(name)
      j_alias = "organism_dynamic_attribute_#{name}"
      "LEFT JOIN dynamic_attribute_values as #{j_alias} ON (#{j_alias}.owner_type = '#{self.to_s}' and #{j_alias}.owner_id = organisms.id and #{j_alias}.dynamic_attribute_id = #{dynamic_attributes_hash[name].id})"
    end
    
    def dynamic_attribute_source_field(column_name)
      da = dynamic_attributes_hash[column_name.to_s]
      dt = da.dynamic_type
      dt.stored_in_field
    end
  
    def dynamic_attribute_select_statement(column_name)
      source_field = dynamic_attribute_source_field(column_name)
      "`organism_dynamic_attribute_#{column_name}`.`#{source_field}` as organisms_#{column_name}"
    end
  
    # returns an hash of string indexed DynamicAttribute models
    def dynamic_attributes_hash
      @dynamic_attributes.inject({}) { |h, da| h[da.name] = da; h}
    end
  
    def dynamic_attributes_names
      dynamic_attributes.map(&:name)
    end
  
    def dynamic_types_hash
      dynamic_attributes.inject({}) { |h, da| h[da.name] = da.dynamic_type.name.to_sym; h}
    end
  
end

