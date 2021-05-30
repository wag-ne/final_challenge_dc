class Operations::Order::Create
  def call(params)
    @order_params = params

    return validate if validate.present?
    proccess
  end

  private

  def validate
    validate_external_code
  end

  def proccess
    @payload = BuildOrderPayloadService.call(@order_params)
    create_order!
    builder = payload_to_camel_case
    ProcessOrderService.call(builder)
  end

  def create_order!
    attributes = @payload
    attributes[:items_attributes].map! { |hash| hash&.except!(:sub_items) }
    @order = Order.create!(attributes)
  end

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

  def validate_external_code
    order = Order.find_by(external_code: @order_params['id'])

    if order.present?
      raise StandardError.new('Pedido já existente')
    end
  end
end
