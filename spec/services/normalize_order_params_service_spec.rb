require 'rails_helper'

describe NormalizeOrderParamsService do
  describe '#call' do
    context 'normalize_params' do
      let(:params) { JSON.parse(File.read('spec/fixtures/raw_order.json')) }
      let(:payload) { JSON.parse(File.read('spec/fixtures/payload.json')) }
      let(:processed) { JSON.parse(File.read('spec/fixtures/processed_order_v2_two.json')) }

      it 'return correct payload' do
        expected = NormalizeOrderParamsService.new(params, payload)
        expect(expected.send(:call).deep_symbolize_keys).to eq(processed.deep_symbolize_keys)
      end
    end
  end
end
