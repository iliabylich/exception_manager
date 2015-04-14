require 'spec_helper'

describe ExceptionManager::Config, reset_config: true do
  subject(:manager) { ExceptionManager }

  let(:exception) do
    begin
      Letter.new('message', 'from@example.com').deliver_to('to@example.com')
    rescue => e
      e
    end
  end

  describe '.enable!/.disable!' do
    context 'when exception manager is enabled' do
      before { manager.enable! }
      it { is_expected.to be_enabled }

      it 'can be disabled' do
        manager.disable!
        expect(manager).to be_disabled
      end

      it 'adds local bindings to exceptions' do
        expect(exception._binding).to_not be_nil
      end
    end

    context 'when exception manager is disabled' do
      before { manager.disable! }
      it { is_expected.to be_disabled }

      it 'can be enabled' do
        manager.enable!
        expect(manager).to be_enabled
      end

      it 'does not add local bindings to exceptions' do
        expect(exception._binding).to be_nil
      end
    end
  end

  describe '.add_filters' do
    before do
      manager.add_filter do |e|
        !e.is_a?(CannotDeliverMessageError)
      end
    end

    it 'adds filters for tracepoint' do
      expect(exception).to be_a(CannotDeliverMessageError)
      expect(exception._binding).to be_nil
    end
  end
end
