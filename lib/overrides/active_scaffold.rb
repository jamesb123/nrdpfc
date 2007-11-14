module ActiveScaffold
  
  def as_reconfigure(model_id = nil, model = nil, &block)
    self.class.as_reconfigure(model_id, model, &block)
    handle_user_settings
  end
    
  module ClassMethods
    def as_reconfigure(model_id = nil, model = nil, &block)
      # converts Foo::BarController to 'bar' and FooBarsController to 'foo_bar' and AddressController to 'address'
      model_id = self.to_s.split('::').last.sub(/Controller$/, '').pluralize.singularize.underscore unless model_id
  
      # TODO - this is a bit hackish.  We're sneaking in a custom model, since the model we're using doesn't have a class name
      @active_scaffold_config = ActiveScaffold::Config::Core.allocate
      self.active_scaffold_config.instance_variable_set("@model", model)
      self.active_scaffold_config.send :initialize, model_id
      
      # run the configuration
      self.active_scaffold_config.configure &block if block_given?
      self.active_scaffold_config._load_action_columns
    end
  end
end