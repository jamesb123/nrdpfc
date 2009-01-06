module ActiveScaffold
  
  def as_reconfigure(model_id = nil, model = nil, &block)
    self.class.as_reconfigure(model_id, model, &block)
    self.active_scaffold_conditions = nil

    handle_user_settings
  end

  module Config
    class Core
      alias initialize_without_defaults initialize
      def initialize(*args)
        initialize_without_defaults(*args)
        self.action_links.add 'download_table', :label => 'Download', :popup => true
      end
    end
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

      active_scaffold_config.actions.each do |mod|
        name = mod.to_s.camelize
        include eval("ActiveScaffold::Actions::#{name}") if ActiveScaffold::Actions.const_defined? name

        # sneak the action links from the actions into the main set
        if link = active_scaffold_config.send(mod).link rescue nil
          active_scaffold_config.action_links << link
        end
      end
    end
  end
end
