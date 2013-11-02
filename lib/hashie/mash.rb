module Hashie
  class Mash
    def initialize()
      @hash = {}
    end

    def method_missing(name, *args)
      mod = name[-1]
      key = name.to_s.delete(mod).to_sym
      if mod == '?'
        @hash.has_key?(key)
      elsif mod == '='
        @hash[key] = args[0]
      else
        key = name
        @hash[key]
      end
    end
  end
end