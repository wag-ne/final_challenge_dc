class TokenService
  URL = URI(ENV['TOKEN_API_URL']).freeze
  EXPIRES = 1.hour

  def get_token(params)
    block_cache_key = "token::customer::#{params}"
    cached_token = Rails.cache.read("#{block_cache_key}")

    return cached_token if Rails.cache.exist?(block_cache_key)

    response = Net::HTTP.get(URL) rescue nil

    response = JSON.parse(response)
    token = response['token']
    token = token.chomp

    Rails.cache.write(block_cache_key, token, expires_in: EXPIRES)
    token
  end
end
