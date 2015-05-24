module ForwardingDsl
  class Dsl
    attr_accessor :this
    attr_accessor :that

    def self.run target, &block
      return target unless block_given?

      case block.arity
      when 0 then
        new(target, block.binding.eval('self')).
          send(:instance_exec, &block)
      when 1 then
        block.call target
      else
        raise ArgumentError.new "Wrong number of arguments. Pass 1 or none."
      end
    end

    def initialize this, that
      @this = this
      @that = that
    end

    def method_missing name, *args, &block
      if this.respond_to? name
        this.public_send name, *args, &block
      else
        that.public_send name, *args, &block
      end
    end

    def respond_to_missing? name, *args
      this.respond_to?(name, *args) ||
        that.respond_to?(name, *args) ||
        super
    end
  end
end
