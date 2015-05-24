module ForwardingDsl
  class Dsl
    attr_accessor :this
    attr_accessor :that

    def self.run target, &block
      new(target, block.binding.eval('self')).
        send(:instance_eval, &block)
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
