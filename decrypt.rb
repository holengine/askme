require 'cgi'
require 'json'
require 'base64'
require 'openssl'

cookie = STDIN.gets.chomp
cookie = CGI.unescape(cookie)
data, iv, auth_tag = cookie.split('--').map do |v|
  Base64.strict_decode64(v)
end
cipher = OpenSSL::Cipher.new('aes-256-gcm')

# Compute the encryption key
secret_key_base = STDIN.gets.chomp
secret = OpenSSL::PKCS5.pbkdf2_hmac(secret_key_base, 'authenticated encrypted cookie', 1000, cipher.key_len,
                                    OpenSSL::Digest.new('SHA256'))
# Setup cipher for decryption and add inputs
cipher.decrypt
cipher.key = secret
cipher.iv  = iv
cipher.auth_tag = auth_tag
cipher.auth_data = ''

# Perform decryption
cookie_payload = cipher.update(data)
cookie_payload << cipher.final
cookie_payload = JSON.parse cookie_payload
# => {"_rails"=>{"message"=>"InRva2VuIg==", "exp"=>nil, "pur"=>"cookie.remember_token"}}

# Decode Base64 encoded stored data
decoded_stored_value = Base64.decode64 cookie_payload['_rails']['message']
stored_value = JSON.parse decoded_stored_value
# => "token"
puts stored_value
