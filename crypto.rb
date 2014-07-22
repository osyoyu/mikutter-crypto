# coding: utf-8

require 'base64'
require 'zlib'

Plugin.create(:crypto) do
  def auto_decrypt(message)
    zstream = Zlib::Inflate.new(Zlib::MAX_WBITS + 32)

    begin
      result = Base64.strict_decode64(message.chomp)

      return auto_decrypt(result)
    rescue => e
      p e
    end
    
    begin
      result = zstream.inflate(message)

      return auto_decrypt(result)
    rescue => e
      p e
    end

    return message
  end

  command(:crypto_auto_decode,
          name: "自動でデコードする",
          condition: Plugin::Command[:HasMessage],
          visible: true,
          role: :timeline) do |target|
            target.messages.each do |message|
              activity :crypto, auto_decrypt(message.to_s)
            end
          end

  command(:crypto_rot13,
          name: "ROT13",
          condition: Plugin::Command[:HasMessage],
          visible: true,
          role: :timeline) do |target|
            target.messages.each do |message|
              activity :crypto, message.to_s.tr("A-Za-z", "N-ZA-Mn-za-m") 
            end
          end

  command(:crypto_rot47,
          name: "ROT47",
          condition: Plugin::Command[:HasMessage],
          visible: true,
          role: :timeline) do |target|
            target.messages.each do |message|
              activity :crypto, message.to_s.tr("\x21-\x7e", "\x50-\x7e\x21-\x4f")
            end
          end
end
