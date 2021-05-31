require 'rails_helper'

describe CreateOrderService do
  describe '#call' do
    before do
      remove_all_records
    end

    let(:params) { JSON.parse(File.read('spec/fixtures/payload.json')) }
    subject { described_class.call(params) }

    context 'When pass valid parameters' do
      it 'returns successfully persisted' do
        expect(subject.persisted?).to be_truthy
      end

      it 'create new order' do
        expect { subject }.to change { Order.count }.by(1)
      end

      it 'create new order items' do
        expect { subject }.to change { Item.count }.by(1)
      end

      it 'create new customer' do
        expect { subject }.to change { Customer.count }.by(1)
      end

      it 'create new address' do
        expect { subject }.to change { Address.count }.by(1)
      end

      it 'create new payment' do
        expect { subject }.to change { Payment.count }.by(1)
      end
    end

    context 'When pass invalid parameters' do
      context 'parameter of order' do
        it 'returns not persisted' do
          params['store_id'] = nil
          expect(subject.persisted?).to be_falsey
        end
      end

      context 'parameter of address' do
        it 'returns not persisted' do
          params['address_attributes'] = {}
          expect(subject.persisted?).to be_falsey
        end
      end

      context 'parameter of customer' do
        it 'returns not persisted' do
          params['customer_attributes'] = {}
          expect(subject.persisted?).to be_falsey
        end
      end

      context 'parameter of items' do
        it 'returns not persisted' do
          params['items_attributes'] = {}
          expect(subject.persisted?).to be_falsey
        end
      end

      context 'parameter of payment' do
        it 'returns not persisted' do
          params['payments_attributes'] = {}
          expect(subject.persisted?).to be_falsey
        end
      end
    end
  end
end
