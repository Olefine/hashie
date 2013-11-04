module Hashie
  class Clash < Hash
    @@mods = ['!']

    def initialize
      @stack = []
      @cur=self
    end

    def parse_modname(method_name)
      mod = method_name[-1]
      if @@mods.include?(mod)
        [mod, method_name[0..-2].to_sym]
      else
        [nil, method_name]
      end
    end

    def process_bang(name)
      if name == :_end
        @cur = @stack.pop
      else
        @stack.push(@cur)
        new_hash = {}
        @cur[name] = new_hash
        @cur = new_hash
      end
      self
    end

    def method_missing(*args)
      mod, name = parse_modname(args[0])
      return process_bang(name) if mod == '!'

      if args.size == 2
        value = args[1]
      elsif args.size > 2
        value = args[1..-1]
      else
        value = nil
      end

      @cur[name] = value
      self
    end
  end
end
