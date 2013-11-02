module Hashie
  class DashItem
    attr_accessor :name, :required, :default
  end

  class Dash
    @@properties = {}
        
    def initialize(hash = {})
      instance = @@properties.except(:default, :requires)
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
      item.required = !!options[:requires]
      @@properties[name] = item
      generate_methods(@@properties)
    end
  end
end


p = Person.new(:name => "Bob")