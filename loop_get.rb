# coding: utf-8

require 'uri'
require 'net/http'
require 'logger'
logger1 = Logger.new($stdout)

success = []
errors = []


loop do
  ipv4uris = %w[
    http://www.bp-musashi.jp
    https://github.com
    https://twitter.com
    http://jin115.com
    https://youtube.com
  ]
  uri = URI(ipv4uris[rand(ipv4uris.count)])
  logger1.info(uri)
  res = Net::HTTP.get_response(uri)
  unless errors.count.zero?
    message = '復帰しました'
    system `say #{message}`
    logger1.info(message)
    errors.clear
  end
  success << res.code
rescue => e
  errors << e
  message = "#{errors.count}回目の失敗です。"
  unless success.count.zero?
    message += "#{success.count}回成功していました。"
  end

  logger1.fatal(message)
  logger1.fatal(e)
  system `say #{message}`
  success.clear
ensure
  sleep 5
end
