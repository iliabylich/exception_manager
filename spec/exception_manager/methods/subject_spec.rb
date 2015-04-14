require 'spec_helper'

describe ExceptionManager::Methods::Subject do
  let(:command) { described_class }

  let(:klass) do
    Class.new do
      def self.local_binding
        binding
      end
    end
  end

  let(:exception_binding) do
    klass.local_binding
  end

  describe '.run' do
    subject(:result) { command.run(exception_binding) }
    it { is_expected.to eq(klass) }
  end
end
