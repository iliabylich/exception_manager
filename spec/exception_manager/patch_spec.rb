require 'spec_helper'

describe ExceptionManager do
  subject(:error) do
    begin
      Letter.new('message', 'from@example.com').deliver_to('to@example.com')
    rescue => e
      e
    end
  end

  describe 'Kernel.raise' do
    it 'still raises exception' do
      expect { raise 'foo' }.to raise_error
    end
  end

  describe 'Exception#locals' do
    let(:expected) do
      {
        exception_message: "'to@example.com' does not want to receive emails from you",
        recipient: 'to@example.com'
      }
    end

    it 'returns Hash of local variables available when #raise happened' do
      expect(error.locals).to eq(expected)
    end
  end

  describe 'Exception#subject' do
    it 'returns context of place when subject was raised' do
      expect(error.subject).to be_a(Letter)
    end
  end

  describe 'Exception#subject_instance_variables' do
    let(:expected) do
      {
        :@message => 'message',
        :@sender => 'from@example.com'
      }
    end

    it 'returns instance variables of #subject when #raise happened' do
      expect(error.subject_instance_variables).to eq(expected)
    end
  end

  describe 'Exception#subject_class_variables' do
    let(:expected) do
      {
        :@@class_variable => 'class variable'
      }
    end

    it 'returns class variables of #subject when #raise happened' do
      expect(error.subject_class_variables).to eq(expected)
    end
  end

  describe 'Exception#summary' do
    let(:expected) do
      {
        locals: instance_of(Hash),
        subject: instance_of(Letter),
        subject_instance_variables: instance_of(Hash),
        subject_class_variables: instance_of(Hash)
      }
    end

    it 'returns all available information combined into single Hash' do
      expect(error.summary).to be_a(Hash)

      expect(error.summary[:locals]).to be_a(Hash)
      expect(error.summary[:subject]).to be_a(Letter)
      expect(error.summary[:subject_instance_variables]).to be_a(Hash)
      expect(error.summary[:subject_class_variables]).to be_a(Hash)
    end
  end
end
