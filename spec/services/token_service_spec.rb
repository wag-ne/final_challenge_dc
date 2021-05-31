require 'rails_helper'

describe TokenService do
  describe '#token' do
    before do
      URL = URI(ENV['TOKEN_API_URL'])
      allow(Net::HTTP).to receive(:get).with(URL).and_return('{\"token\":\"MMF0YXRhKzIwMjEtMDUtMzFUMTM6NDE6NDcrMDA6MDA=\\n\"}')
    end

    it 'return a valid token without cache' do
      token = subject.send(:get_token, 12345)
      expected = 'MMF0YXRhKzIwMjEtMDUtMzFUMTM6NDE6NDcrMDA6MDA='
      expect(token.to_s).to eq(expected.to_s)
    end
  end
end
