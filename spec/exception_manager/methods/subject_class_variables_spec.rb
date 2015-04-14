require 'spec_helper'

describe ExceptionManager::Methods::SubjectClassVariables do
  let(:command) { described_class }

  let(:klass) do
    Class.new do
      self.class_variable_set(:@@a, 1)

      def local_binding
        binding
      end
    end
  end

  let(:exception_binding) { klass.new.local_binding }

  describe '.run' do
    subject { command.run(exception_binding) }
    let(:expected) { { :@@a => 1 } }
    it { is_expected.to eq(expected) }
  end
end