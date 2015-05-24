require_relative '../spec_helper'

describe ForwardingDsl::Adapter do
  subject{ ForwardingDsl::Adapter.new }

  it 'can build instances' do
    expect(subject).to be_a(ForwardingDsl::Adapter)
  end
end
