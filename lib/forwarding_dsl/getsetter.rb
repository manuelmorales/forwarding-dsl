module ForwardingDsl
  module Getsetter
    NOT_SET = Object.new

    def self.included klass
      klass.extend ClassMethods
    end

    module ClassMethods
      def getsetter *names
        names.each do |name|
          define_method name do |value = NOT_SET|
            if value == NOT_SET
              instance_variable_get "@#{name}"
            else
              send "#{name}=", value
            end
          end

          define_method "#{name}=" do |value|
            instance_variable_set "@#{name}", value
          end
        end
      end
    end
  end
end
