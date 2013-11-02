module Hashie
  class Mash
    def initialize()
      @hash = {}
      @nested_hashes = {}
    end

    def method_missing(name, *args)
      mod = name[-1]
      key = name.to_s.delete(mod).to_sym
      if mod == '?'
        @hash.has_key?(key)
      elsif mod == '='
        @hash[key] = args[0]
      elsif mod == '!'
        if @nested_hashes.has_key?(:key)
          @nested_hashes[key]
        else
          @nested_hashes[key] = Mash.new
        end
      else
        key = name
        if @nested_hashes.has_key?(key)
          @nested_hashes[key]
        else
          @hash[key]
        end
      end
    end

    def inspect
      s = '<' + self.class.ancestors.first.to_s
      s << ' ' if !@hash.empty?
      @hash.each do |k,v|
        s << "#{k}=\"#{v}\""
      end
      s << '>'
    end
  end
end