class TokenService
  URL = URI(ENV['TOKEN_API_URL']).freeze
  EXPIRES = 1.hour

  def get_token(params)
    block_cache_key = "token::customer::#{params}"
    return block_cache_key if Rails.cache.exist?(block_cache_key)

    response = Net::HTTP.get(URL) rescue nil

    Rails.cache.write(block_cache_key, 'true', expires_in: EXPIRES)
    response[10..52]
  end
end
