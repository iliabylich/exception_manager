require 'spec_helper'

describe ExceptionManager::Methods::Locals do
  let(:command) { described_class }
  let(:exception_binding) { a = 1; binding }

  describe '.run' do
    let(:expected) { { a: 1 } }
    subject(:result) { command.run(exception_binding) }
    it { is_expected.to eq(expected) }
  end
end
