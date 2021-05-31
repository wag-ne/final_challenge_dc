class NormalizeOrderParamsService < BaseService
  def initialize(params, payload)
    @order_params = params
    @payload = payload
  end

  def call
    payload_to_camel_case
  end

  private

  def payload_to_camel_case
    camel_case_payload.merge!({ total_shipping: total_shipping })
  end

  def camel_case_payload
    @payload.deep_transform_keys! do |key|
      key.to_s.gsub('attributes', '').camelize(:lower)
    end
  end

  def total_shipping
    @order_params['total_shipping'] || 0.0
  end
end
