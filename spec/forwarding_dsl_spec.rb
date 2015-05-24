require_relative 'spec_helper'

describe ForwardingDsl do
  it 'has a version' do
    expect(ForwardingDsl::VERSION).not_to be_nil
  end

  it 'delegates .run() to Dsl' do
    target = double('target')
    expect(target).to receive(:some_method)

    ForwardingDsl.run target do
      some_method
    end
  end
end
