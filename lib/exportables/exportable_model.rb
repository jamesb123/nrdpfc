module Exportables::ExportableModel
  
  class << self
    def extended(klass)
      @models ||= []
      @models << klass
    end
    
    def models
      return @models if @models_loaded
      
      load_all_models
      @models.sort! {|a,b| a.exportable_name <=> b.exportable_name }
      @models_loaded = true
      @models
    end
    
    def load_all_models
      return @all_models_loaded if @all_models_loaded
      
      Dir["#{RAILS_ROOT}/app/models/**/*.rb"].each {| file | require_or_load file }
      
      @all_models_loaded = true
    end
  end
  
  def path_to_exportable_table(target_table_name, breadcrumbs = [])
    target_table_name = target_table_name.to_s
    return [] if target_table_name == self.table_name
    
    possibilities = []
    exportable_reflections.each_pair do |name, reflection|
      table_name = reflection.class_name.constantize.table_name
      next if breadcrumbs.include?(table_name)
      return [name] if table_name == target_table_name
      
      possibility = reflection.class_name.constantize.path_to_exportable_table(target_table_name, breadcrumbs + [self.exportable_table_name])
      possibilities << [name] + possibility if possibility
    end
    
    possibilities.sort{ |a,b| a.length <=> b.length }.first
  end
  
  def exportable?
    true
  end
  
  def exportable_fields
    self.columns.map(&:name)
  end
  
  def exportable_non_id_fields
    exportable_fields.select{|f| ! /(^|_)id$/.match(f)}
  end
  
  def exportable_table_name
    self.table_name
  end
  
  def exportable_name
    self.table_name
  end
  
  def exportable_filter(field, operator, operand)
    qp = QueryPiece.new
    return(qp) if operator.strip.blank?
    qp.where << Where("#{exportable_table_name}.#{field} #{operator} ?", operand).to_s
    qp
  end
  
  def exportable_reflections
    Exportables::ExportableModel.load_all_models
    self.reflections.select_hash do |k, v|
      next if v.through_reflection || v.options[:conditions]
      begin
        klass = v.class_name.constantize
        klass.respond_to?(:exportable?) && klass.exportable?
      rescue
        raise "nil reflection on #{self.to_s} for reflection #{k}"
      end
    end
  end
  
  def exportable_select(column_name)
    QueryPiece.new :select => "`#{exportable_table_name}`.`#{column_name}` as `#{self.table_name}_#{column_name}`"
  end
  
  # Organism.exportable_from(:parent => Project, :association => 'organisms').
  def exportable_from(options = {})
    if options[:parent]
      raise ArgumentError, "Expected - :association must be specified with parent" unless options[:association]
      p_association = options[:parent].exportable_reflections[p_association]
      p_table_name = options[:parent].table_name
      t_foreign_key = p_association.foreign_key
      
      QueryPiece.new :join => "LEFT JOIN #{exportable_table_name} ON (#{exportable_table_name}.project_id = #{p_table_name}.id)"
    else
      QueryPiece.new :from => "FROM #{exportable_table_name}"
    end
  end
  
  def exportable_join(name, *other_tables)
    other_tables = other_tables.flatten
    criteria = []
    r = exportable_reflections[name]
    raise ArgumentError, "Association #{name} doesn't exist on #{self.to_s}" if r.nil?
    remote_class = r.class_name.constantize
    criteria << remote_class.exportable_join_criteria(self, r)
    
    # check for any other joins that this table can link to - we want to make our queries as tight as possible
    other_relections = remote_class.exportable_reflections.values
    other_tables.each do |table|
      table = table.to_s
      reflection = other_relections.find{ |r| r.class_name.constantize.table_name == table && r.options[:conditions].nil? }
      next if reflection.nil?
      criteria << r.class_name.constantize.exportable_join_criteria(remote_class, reflection)
    end
    QueryPiece.new :join => "LEFT JOIN #{remote_class.exportable_table_name} ON (#{criteria.uniq * ' AND '})"
  end
  
  def exportable_join_criteria(parent_class, association)
    case association.macro
    when :has_many, :has_one
      "#{parent_class.exportable_table_name}.id = #{exportable_table_name}.#{association.primary_key_name}"
    when :belongs_to
      "#{exportable_table_name}.id = #{parent_class.exportable_table_name}.#{association.primary_key_name}"
    end
  end
  
    
  def exportable_column_types_hash
    self.columns.inject({}) { |h,c| h[c.name.to_s] = c.type.to_sym; h }
  end
  
  #
  ##
  ###
  protected
end
