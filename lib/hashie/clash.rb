module Hashie
  class Clash < Hash
    def initialize
      @main={}
      @cur=@main
    end

    def method_missing(name, arg)
      self[name]=arg
      self
    end
  end
end
