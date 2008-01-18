module Exportables::ExportableModel
  
  class << self
    def extended(klass)
      @models ||= []
      @models << klass
    end
    
    def models
      return @models if @loaded 
      
      Dir["#{RAILS_ROOT}/app/models/**/*.rb"].each {| file | require file }
      
      @loaded = true
      @models
    end
  end
  
  def path_to_exportable_model(target_model, breadcrumbs = [])
    target_model = target_model.to_s
    
    possibilities = []
    exportable_reflections.each_pair do |name, reflection|
      next if breadcrumbs.include?(reflection.class_name)
      return [name] if reflection.class_name == target_model
      
      possibility = reflection.class_name.constantize.path_to_exportable_model(target_model, breadcrumbs + [self.to_s])
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
  
  def exportable_table_name
    self.table_name
  end
  
  def exportable_name
    self.table_name
  end
  
  def exportable_reflections
    self.reflections.select_hash do |k, v|
      klass = v.class_name.constantize
      klass.respond_to?(:exportable?) && klass.exportable?
    end
  end
  
  def exportable_select(column_name)
    QueryPiece.new :select => "`#{exportable_table_name}`.`#{column_name}` as `#{self.to_s.underscore}_#{column_name}`"
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
  
  def exportable_join(name)
    r = exportable_reflections[name]
    raise ArgumentError, "Association doesn't exist: #{name}" if r.nil?
    r.class_name.constantize.exportable_join_from_table(self, r)
  end
  
  def exportable_join_from_table(parent_class, association)
    case association.macro
    when :has_many, :has_one
      QueryPiece.new :join => "LEFT JOIN #{exportable_table_name} ON (#{parent_class.exportable_table_name}.id = #{exportable_table_name}.#{association.primary_key_name})"
    when :belongs_to
      QueryPiece.new :join => "LEFT JOIN #{exportable_table_name} ON (#{exportable_table_name}.id = #{parent_class.exportable_table_name}.#{association.primary_key_name})"
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
