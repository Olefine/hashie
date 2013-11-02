module Hashie
  class DashItem
    attr_accessor :name, :required, :default
  end

  class Dash
    @@properties = {}

    def initialize(hash = {})
      @@properties.each do |k, v|
        if v.required && !hash.has_key?(k)
          raise ArgumentError, make_error_str(k)
        end
      end
      hash.each do |k, v|
        var_name = ("@" + k.to_s).to_sym
        instance_variable_set(var_name, v)
      end
    end

    def make_error_str(name)
      "The property '#{name}' is required for this Dash."
    end


    def self.generate_methods(args)
      args.each do |key, value|
        module_eval "def #{key}; @#{key}; end"
        module_eval "def #{key}=(val); @#{key} = val; end"
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
  end
end
