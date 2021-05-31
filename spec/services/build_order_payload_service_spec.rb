require 'rails_helper'

describe BuildOrderPayloadService do
  describe '#call' do
    context 'valid payload' do
      let(:params) { JSON.parse(File.read('spec/fixtures/raw_order.json')) }
      let(:processed) { JSON.parse(File.read('spec/fixtures/payload.json')) }
      let(:payload) { subject.send(:call, params) }

      it 'return correct payload' do
        expect(payload.deep_symbolize_keys).to eq(processed.deep_symbolize_keys)
      end
    end
  end
end
