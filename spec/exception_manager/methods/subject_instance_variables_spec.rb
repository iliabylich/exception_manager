require 'spec_helper'

describe ExceptionManager::Methods::SubjectInstanceVariables do
  let(:command) { described_class }

  let(:klass) do
    Class.new do
      def local_binding
        @a = 1
        binding
      end
    end
  end

  let(:exception_binding) { klass.new.local_binding }

  describe '.run' do
    subject(:result) { command.run(exception_binding) }
    let(:expected) { { :@a => 1 } }
    it { is_expected.to eq(expected) }
  end
end
