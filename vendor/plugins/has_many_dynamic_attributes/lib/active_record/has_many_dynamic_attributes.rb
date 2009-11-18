module ActiveRecord # :nodoc:

  # Flex attributes allow for the common but questionable database design of
  # storing attributes in a thin key/value table related to some model.
  #
  module HasManyDynamicAttributes
    def self.included(base) # :nodoc:
        base.extend ClassMethods
    end

    module ClassMethods

      def has_many_dynamic_attributes(options={})

        cattr_accessor :this_class_name
        self.this_class_name = self.class_name
        
        options[:scoped_by] ||= self.class_name
        
        cattr_accessor :scoped_by_class
        self.scoped_by_class = options[:scoped_by].constantize
        
        begin
          options[:scoped_by].constantize
        rescue
          Object.const_set(options[:scoped_by],
            Class.new(ActiveRecord::Base)).class_eval do
              has_many :dynamic_attributes, :as => :scoper
              
              def self.reloadable? #:nodoc:
                false
              end
          end
        end

        # Init option storage if necessary
        cattr_accessor :dynamic_options
        self.dynamic_options ||= Hash.new

        # Return if already processed.
        return if self.dynamic_options.keys.include? options[:scoped_by]

        # Mix in instance methods
        send :include, ActiveRecord::HasManyDynamicAttributes::InstanceMethods

        self.scoped_by_class = options[:scoped_by].constantize
        cattr_accessor :scope_relationship
        self.scope_relationship = options[:scoped_by].tableize.singularize.to_sym

        # Modify main class
        class_eval do
          has_many :dynamic_attribute_values, :as => :owner, :dependent => :destroy

          # The following is only setup once
          unless private_method_defined? :method_missing_without_dynamic_attributes
            # Carry out delayed actions before save
            after_validation_on_update :save_modified_dynamic_attributes

            # Make attributes seem real
            alias_method_chain :method_missing, :dynamic_attributes

            private
              alias_method_chain :read_attribute, :dynamic_attributes
              alias_method_chain :write_attribute, :dynamic_attributes
          end
        end

      end
    end

    module InstanceMethods

      #list of all dynamic_attributes scoped by this Model Scoper
      #attributes may not be currently stored for this instance, but available (defined) by the Scoper
      def dynamic_attributes
        scoper = send scope_relationship
        attributes = DynamicAttribute.find(:all, 
                    :conditions => ["dynamic_attributes.scoper_type = ? and dynamic_attributes.scoper_id = ? and dynamic_attributes.owner_type = ?", 
                    self.scoped_by_class.class_name, scoper.id, self.this_class_name], :include => :dynamic_attribute_values)
                    
      end
        
      def dynamic_attributes_cache
        @dynamic_attributes_cache ||= HashWithIndifferentAccess.new
      end
      
      def has_dynamic_attribute?(name)
        return dynamic_attributes_cache[name] if dynamic_attributes_cache[name]
        return nil if name == "#{scope_relationship}_id" or name == "id"
        
        conditions = ["dynamic_attributes.name = :name", "dynamic_attributes.owner_type = :owner_type"]
        conditions_options = {
          :name => name, 
          :owner_type => self.this_class_name
        }

        if respond_to?(scope_relationship) && (scoper = send(scope_relationship) )
          conditions.concat ["dynamic_attributes.scoper_id = :scoper_id", "dynamic_attributes.scoper_type = :scoper_type"]
          conditions_options.update(
            :scoper_type => self.scoped_by_class.class_name, 
            :scoper_id => scoper.id
          )
        end
        
        attribute = DynamicAttribute.find(:first, :conditions => [conditions * " AND ", conditions_options])


        return nil unless attribute
                    
        attribute_value = dynamic_attribute_values.find_by_dynamic_attribute_id(attribute.id, :conditions => ['owner_id = ? and owner_type = ?', self.id, self.this_class_name])
        #auto-create an attribute value that should exist            
        if attribute && ! attribute_value
          attribute_value = dynamic_attribute_values.build(:dynamic_attribute => attribute, :owner => self)
        end

        #add to cache and return
        dynamic_attributes_cache[name] = attribute_value
        attribute_value
      end
  
      private
        # Called after validation on update so that flex attributes behave
        # like normal attributes in the fact that the database is not touched
        # until save is called.
        def save_modified_dynamic_attributes
          return if dynamic_attributes_cache.nil?

          dynamic_attributes_cache.values.each { |attr_value| attr_value.save }
          dynamic_attributes_cache.clear
        end

        # Overrides ActiveRecord::Base#read_attribute
        def read_attribute_with_dynamic_attributes(attr_name)
          attr_name = attr_name.to_s
          begin
            if ! (ret_val = read_attribute_without_dynamic_attributes(attr_name)).nil?
              return ret_val
            elsif the_attribute_value = has_dynamic_attribute?(attr_name)
              return the_attribute_value.send(the_attribute_value.storage_field)
            else
              return nil
            end
          end
        end

        # Overrides ActiveRecord::Base#write_attribute
        def write_attribute_with_dynamic_attributes(attr_name, value)
          attr_name = attr_name.to_s

          if the_attribute_value = has_dynamic_attribute?(attr_name)

            value_field = the_attribute_value.storage_field
          
            value_setter_field = (value_field.to_s + '=').to_sym
            ret_val = the_attribute_value.send(value_setter_field, value)
              
            return ret_val
          end

          write_attribute_without_dynamic_attributes(attr_name, value)
        end

        # Implements dynamic attributes as if real getter/setter methods
        # were defined.
        def method_missing_with_dynamic_attributes(method_id, *args, &block)
          begin
            method_missing_without_dynamic_attributes method_id, *args, &block
          rescue NoMethodError => e
            attr_name = method_id.to_s.sub(/\=$/, '')
            if related_attr = has_dynamic_attribute?(attr_name)
              if method_id.to_s =~ /\=$/
                return write_attribute_with_dynamic_attributes(attr_name, args[0])
              else
                return read_attribute_with_dynamic_attributes(attr_name)
              end
            end
            raise e
          end
        end
        
    end
    
  end
    
end
