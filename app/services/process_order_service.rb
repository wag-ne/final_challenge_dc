# frozen_string_literal: true

class ProcessOrderService < BaseService
  URL = URI(ENV['API_URL']).freeze

  def call(payload)
    @payload = payload
    response = connection.request(request(payload.to_json))

    response.code == '200'
  end

  private

  def request(body)
    headers = { Authorization: token }
    req = Net::HTTP::Post.new(URL.path, headers)
    req['Content-Type'] = 'application/json'
    req['X-Sent'] = Time.zone.now.strftime('%Hh%M - %d/%m/%y')
    req.body = body
    req
  end

  def connection
    http = Net::HTTP.new(URL.host, URL.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    http
  end

  def token
    customer_identifier = @payload.dig('customer', 'externalCode')
    token = TokenService.new.get_token(customer_identifier)
    token
  end
end
