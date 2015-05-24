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

    describe 'with no args' do
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

    describe 'with 1 arg' do
      it 'forwards no messages to the target' do
        expect(target).not_to receive(:a_method)

        expect do
          subject.run target do |t|
            a_method 42
          end
        end.to raise_error(NoMethodError)
      end

      it 'yields the target' do
        subject.run target do |t|
          expect(t).to be target
        end
      end

      it 'runs in the outer context' do
        outer_context = self

        subject.run target do |t|
          expect(self).to be outer_context
        end
      end
    end

    describe 'with more args' do
      it 'raises exception' do
        expect(target).not_to receive(:a_method)

        expect do
          subject.run target do |t, x|
          end
        end.to raise_error(ArgumentError)
      end
    end

    describe 'with no block' do
      it 'returns the target' do
        expect(subject.run target).to be target
      end
    end

    describe 'with a zero arity lambda' do
      it 'works normally' do
        expect(target).to receive(:a_method)
        block = lambda { a_method }

        subject.run target, &block
      end
    end
  end
end
