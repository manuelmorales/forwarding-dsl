require "forwarding_dsl/version"

module ForwardingDsl
  autoload :Dsl, 'forwarding_dsl/dsl'
  autoload :Getsetter, 'forwarding_dsl/getsetter'

  def self.run *args, &block
    Dsl.run *args, &block
  end
end
