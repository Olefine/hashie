module Hashie
  class DashItem
    attr_accessor :name, :required, :default
  end

  class Dash
    def initialize(*args)
      # args.each do |k,v|
      # end
    end

    @@properties = {}

    def self.property(name, options)
      item=DashItem.new
      item.name=name
      item.default = options[:default]
      item.required = !!options[:requires]
      @@properties[name]=item
    end
  end
end
