class Operations::Order::Create
  def call(params)
    validations = validate(params)
    return validations if validations.present?

    ActiveRecord::Base.transaction do
      proccess(params)
      rescue => e
        puts "#{e.message} - #{e.backtrace}"
    end
  end

  private

  def validate(params)
    validate_external_code(params)
  end

  def proccess(params)
    payload = BuildOrderPayloadService.call(params)
    return if payload.nil?
    CreateOrderService.call(payload)
    normalized_params = NormalizeOrderParamsService.new(params, payload).call
    ProcessOrderService.call(normalized_params)
  end

  def validate_external_code(params)
    order = Order.find_by(external_code: params['id'])

    if order.present?
      raise StandardError.new('Pedido já existente')
    end
  end
end
