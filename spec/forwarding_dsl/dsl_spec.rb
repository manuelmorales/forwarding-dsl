require_relative '../spec_helper'

describe ForwardingDsl::Dsl do
  let(:target_class) do
    Class.new do
      def a_method
      end

      private

      def a_private_emthod
      end
    end
  end

  let(:target) { target_class.new }

  let(:an_external_method) { :external_result }

  describe '.run' do
    subject{ ForwardingDsl::Dsl }

    it 'forwards messages to the target' do
      expect(target).to receive(:a_method).with(42)

      subject.run target do
        a_method 42
      end
    end

    it 'responds_to? target methods' do
      subject.run target do
        expect(respond_to?(:a_method)).to be true
      end
    end

    it 'hides private methods' do
      expect do
        subject.run target do
          a_private_method
        end
      end.to raise_error(NoMethodError)
    end

    it 'allows calling methods from the outside' do
      expect(target).to receive(:a_method).with :external_result

      subject.run target do
        a_method an_external_method
      end
    end

    it 'responds_to? external methods' do
      subject.run target do
        expect(respond_to?(:an_external_method)).to be true
      end
    end

    it 'allows using this' do
      subject.run target do
        expect(this).to be target
      end
    end

    it 'allows using that' do
      outer_context = self

      subject.run target do
        expect(that).to be outer_context
      end
    end
  end
end
