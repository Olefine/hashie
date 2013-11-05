module Hashie
  class Trash
    @@associated_names = {}
    @@lambdas_to_call  = {}
    def initialize(attrs_hash = {})
      @@associated_names.each do |name, associated_name|
        instance_variable_set("@#{name}", attrs_hash[associated_name])
      end
      @@lambdas_to_call.each do |name, transform_func|
        if attrs_hash.has_key?(name) || attrs_hash.has_key?(@@associated_names[name])
          instance_variable_set("@#{name}", transform_func.call(instance_variable_get("@#{name}")))
        end
      end
    end
    
    def self.property(property_name, property_options)
      if property_options.has_key?(:from)
        @@associated_names[property_name] = property_options[:from]
      else
        @@associated_names[property_name] = property_name
      end
      
      module_eval "def #{property_name}; @#{property_name}; end"
      module_eval "def #{property_name}=(val); @#{property_name} = val; end"
      
      if property_options[:with]
        @@lambdas_to_call[property_name] = property_options[:with]
      end

      if property_options[:transform_with]
        @@lambdas_to_call[property_name] = property_options[:transform_with]
      end
    end
  end
end
