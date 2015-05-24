require "forwarding_dsl/version"

module ForwardingDsl
  autoload :Dsl, 'forwarding_dsl/dsl'

  def self.run *args, &block
    Dsl.run *args, &block
  end
end
