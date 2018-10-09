require 'net/http'

module ApiHelper
  def query(url)
    url = URI(url)

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Get.new(url)
    request["pragma"] = 'no-cache'
    request["dpz-language"] = 'en'
    request["accept-language"] = 'en-US,en;q=0.9,en-CA;q=0.8'
    request["user-agent"] = 'Mozilla/5.0 (X11; Windows x86_64) AppleWebKit/520.92 (KHTML, like Gecko) Chrome/60.0.1974.20 Safari/520.92'
    request["accept"] = 'application/json, text/javascript, */*; q=0.01'
    request["dpz-market"] = 'CANADA'
    request["cache-control"] = 'no-cache'
    request["referer"] = 'https://order.dominos.ca/assets/build/xdomain/proxy.html'
    request["market"] = 'CANADA'
    request["connection"] = 'keep-alive'

    http.request(request)
  end
end
