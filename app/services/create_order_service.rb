# frozen_string_literal: true

class CreateOrderService < BaseService
  def call(params)
    create_order!(params)
  end

  private

  def create_order!(params)
    attributes = params.deep_symbolize_keys
    attributes[:items_attributes]&.map { |hash| hash&.except!(:sub_items) }
    Order.create(attributes)
  end
end
