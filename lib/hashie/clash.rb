module Hashie
  class Clash < Hash
    def initialize
      @main={}
      @cur=@main
    end

    def method_missing(*args)
      name = args[0]
      if args.size == 2
        value = args[1]
      elsif args.size > 2
        value = args[1..-1]
      else
        value = nil
      end
      self[name] = value
      self
    end
  end
end
