module Hashie
  class Clash < Hash
    @@mods = ['!']

    def initialize
      @stack = []
      @cur = self
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

    def process_normal(name, new_value)
      current_value = @cur[name]
      if current_value.class == Hash && new_value.class == Hash
        value = current_value.merge(new_value)
      else
        value = new_value
      end
      @cur[name] = value
      self
    end

    def extract_value(args)
      if args.size == 1
        args[0]
      elsif args.size > 1
        args
      else
        nil
      end
    end

    def method_missing(method_name, *args)
      mod, name = parse_modname(method_name)
      case mod
      when '!'
        process_bang(name)
      else
        process_normal(name, extract_value(args))
      end
    end
  end
end
