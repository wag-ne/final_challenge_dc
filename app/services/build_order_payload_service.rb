class BuildOrderPayloadService < BaseService
  def call(params)
    payload(params)
  end

  def payload(params)
    {
      external_code: params['id'].to_s,
      store_id: params['store_id'],
      sub_total: sub_total,
      delivery_fee: params['total_shipping'].to_s,
      total: params['total_amount_with_shipping'].to_s,
      dt_order_create: params['date_created'],
      postal_code: params['shipping']['receiver_address']['zip_code'],
      number: params['shipping']['receiver_address']['street_number'],
      address_attributes: address_block(params),
      customer_attributes: customer_block(params),
      items_attributes: items_block(params),
      payments_attributes: payments_block(params)
    }
  rescue
    {}
  end

  private

  def sub_total
    format('%<total>.2f', total: params['total_amount'])
  rescue
    0.0
  end

  def country
    params['shipping']['receiver_address']['country']['id']
  rescue
    'BR'
  end

  def address_block(params)
    receiver_address = params['shipping']['receiver_address']
    {
      country: country,
      state: receiver_address['state']['id'],
      city: receiver_address['city']['name'],
      district: receiver_address['neighborhood']['name'],
      street: receiver_address['street_name'],
      complement: receiver_address['comment'],
      latitude: receiver_address['latitude'],
      longitude: receiver_address['longitude'],
    }
  end

  def customer_block(params)
    buyer = params['buyer']
    buyer_phone = params['buyer']['phone']

    {
      external_code: buyer['id'].to_s,
      name: buyer['nickname'].to_s,
      email: buyer['email'].to_s,
      contact: "#{buyer_phone['area_code']}#{buyer_phone['number']}"
    }
  rescue NoMethodError
    {}
  end

  def items_block(params)
    params['order_items'].map do |item|
      {
        external_code: item['item']['id'],
        name: item['item']['title'],
        price: item['full_unit_price'],
        quantity: item['quantity'],
        total: item['unit_price'].to_f * item['quantity'].to_i,
        sub_items: []
      }
    end
  rescue NoMethodError
    []
  end

  def payments_block(params)
    params['payments'].map do |payment|
      {
        type: payment['payment_type'].upcase,
        value: payment['total_paid_amount']
      }
    end
  rescue NoMethodError
    []
  end
end
