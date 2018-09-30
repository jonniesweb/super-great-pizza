class FetcherService
  THREAD_POOL_SIZE = 10
  def self.call
    range = 3000..20000
    range.each do |code|
      FetchDiscountJob.perform_later(code)
    end
  end

  def self.run(code)
    time = Time.now

    url = URI("https://order.dominos.ca/power/store/10503/coupon/#{code}?lang=en")

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Get.new(url)
    request["pragma"] = 'no-cache'
    # request["accept-encoding"] = 'gzip, deflate, br'
    request["dpz-language"] = 'en'
    request["accept-language"] = 'en-US,en;q=0.9,en-CA;q=0.8'
    request["user-agent"] = 'Mozilla/5.0 (X11; Windows x86_64) AppleWebKit/520.92 (KHTML, like Gecko) Chrome/60.0.1974.20 Safari/520.92'
    request["accept"] = 'application/json, text/javascript, */*; q=0.01'
    request["dpz-market"] = 'CANADA'
    request["cache-control"] = 'no-cache'
    request["referer"] = 'https://order.dominos.ca/assets/build/xdomain/proxy.html'
    request["market"] = 'CANADA'
    request["connection"] = 'keep-alive'

    response = http.request(request)

    if response.code == '404'
      # code doesn't exist
    elsif response.code == '200'
      process_discount!(response.body)
    else
      json = JSON.parse(response.body)
      Rails.logger.warn "unexpected response: #{response.code}"
      Rails.logger.warn json.inspect
    end

    Rails.logger.info "finish #{code}-#{response.code} in #{(Time.now - time).seconds}"
  end

  def self.process_discount!(raw_json)
    json = JSON.parse(raw_json)
    code = json.dig('Code')

    discount = Discount.find_or_initialize_by(code: code)
    discount.json = json
    discount.name = json.dig('Name')

    product_codes = json.dig('ProductGroups')[0].dig('ProductCodes')
    product_types = product_codes.map do |code|
      ProductType.find_or_create_by!(code: code)
    end

    discount.product_types = product_types
    discount.save!
  end
end
