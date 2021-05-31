# frozen_string_literal: true

require 'rails_helper'

describe Operations::Order::Create do
  before do
    remove_all_records
  end

  describe '#call' do
    let(:params) { JSON.parse(File.read('spec/fixtures/raw_order.json')) }
    context 'when return success' do
      it 'execute all requests and return true' do
        expect(subject.send(:call, params)).to eq(true)
      end
    end

    context 'when return fail' do
      it 'when exist an order' do
        expect(subject.send(:call, params)).to eq(true)
        expect{subject.send(:call, params)}.to raise_error(StandardError) #try create an order with an existent id
      end
    end
  end
end
