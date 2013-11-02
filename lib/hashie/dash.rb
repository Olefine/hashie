module Hashie
  class DashItem
    attr_accessor :name, :required, :default
  end

  class Dash
    @@properties = {}

    def initialize(hash = {})
      @@properties.each do |property_name, property_value|
        name = make_instance_name(property_name)
        if hash.has_key?(property_name)
          instance_variable_set(name, hash[property_name])
        elsif property_value.required
          raise ArgumentError, make_error_str(property_name)
        elsif !property_value.default.nil?
          instance_variable_set(name, property_value.default)
        end
      end
    end
    
    def [](property_name)
      name = make_instance_name(property_name)
      if instance_variable_defined?(name)
        instance_variable_get(name)
      else
        raise NoMethodError
      end
    end
    
    def self.generate_methods(args)
      args.each do |key, value|
        module_eval "def #{key}; @#{key}; end"
        if value.required
          error_str = make_error_str_base(key)
          module_eval "def #{key}=(val); raise(ArgumentError, \"#{error_str}\"); end"
        else
          module_eval "def #{key}=(val); @#{key} = val; end"
        end
      end
    end

    def self.property(name, options = {})
      item = DashItem.new
      item.name = name
      item.default = options[:default]
      item.required = !!options[:required]
      @@properties[name] = item
      generate_methods(@@properties)
    end
    
    private
    def make_instance_name(property_name)
      "@#{property_name}"
    end
    
    def make_error_str(property_name)
      self.class.make_error_str_base
    end
    
    def self.make_error_str_base(property_name)
      "The property '#{property_name}' is required for this Dash."
    end
  end
end
