require_relative '../spec_helper'

RSpec.describe ForwardingDsl::Getsetter do
  subject { subject_class.new }
  let(:subject_class) { Class.new { include ForwardingDsl::Getsetter } }

  describe 'getsetter()' do
    it 'allows setting an attribute passing it as an argument' do
      subject_class.class_eval do
        getsetter :name
      end

      subject.name 'Test'
      expect(subject.name).to eq 'Test'
    end

    it 'allows setting an attribute by equality' do
      subject_class.class_eval do
        getsetter :name
      end

      subject.name = 'Test'
      expect(subject.name).to eq 'Test'
    end

    it 'allows passing several names' do
      subject_class.class_eval do
        getsetter :name, :surname
      end

      subject.surname 'Test'
      expect(subject.surname).to eq 'Test'
    end
  end
end
