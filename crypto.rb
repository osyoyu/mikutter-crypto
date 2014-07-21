# coding: utf-8

require 'base64'
require 'zlib'

Plugin.create(:crypto) do
  zstream = Zlib::Inflate.new(Zlib::MAX_WBITS + 32)

  command(:crypto_decode_base64,
          name: "base64 としてデコード",
          condition: Plugin::Command[:HasMessage],
          visible: true,
          role: :timeline) do |target|
            target.messages.each do |message|
              activity :system, message.to_s =~ /[A-Za-z0-9=]+/ ? Base64.decode64(message.to_s) : "Base64じゃないっぽい"
            end
          end

  command(:crypto_uncompress_gzip,
          name: "base64 デコード + gzip 展開",
          condition: Plugin::Command[:HasMessage],
          visible: true,
          role: :timeline) do |target|
            target.messages.each do |message|
              activity :system, message.to_s =~ /[A-Za-z0-9=]+/ ? zstream.inflate(Base64.decode64(message.to_s)) : "Base64じゃないっぽい"
            end
          end
end
