require 'net/http'

class FetcherService
  THREAD_POOL_SIZE = 10
  DEFAULT_STORE = 10503
  HOST = 'order.dominos.ca'

  def self.call
    range = 3000..20000
    range.each do |code|
      FetchDiscountJob.perform_later(code)
    end
  end

  def self.run(code, store_id: DEFAULT_STORE)
    time = Time.now

    response = query_api(HOST, store_id, code)

    if response.code == '404'
      remove_discount(response.body)
    elsif response.code == '200'
      process_discount(response.body)
    else
      json = JSON.parse(response.body)
      Rails.logger.warn "unexpected response: #{response.code}"
      Rails.logger.warn json.inspect
    end

    Rails.logger.info "finish #{code}-#{response.code} in #{(Time.now - time).seconds}"
  end

  def self.test_one
    process_discount(Discount.find_by(id: 41).json)
  end

  def self.reprocess_all
    Discount.all.each do |discount|
      process_discount(discount.json)
    end
  end

  def self.query_api(host, store_id, discount_code)
    url = URI("https://#{host}/power/store/#{store_id}/coupon/#{discount_code}?lang=en")

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

  def self.process_discount(raw_json)
    json = case raw_json
    when Hash
      raw_json
    when String
      JSON.parse(raw_json)
    end
    code = json.dig('Code')

    discount = Discount.find_or_initialize_by(code: code)
    discount.json = json
    discount.name = json.dig('Name')
    discount.location = json.dig('StoreID')&.to_i
    discount.last_checked = Time.current.utc
    discount.price = json.dig('Price')
    discount.removed = false
    discount.save!

    json.dig('ProductGroups').each do |product_group|
      group = discount.discount_product_type_groups.find_or_initialize_by(group_type: product_group['Default']['PageCode'])
      group.required_quantity = product_group['RequiredQty']
      group.max_quantity = product_group['MaximumQty']
      group.save! if group.changed?

      product_codes = product_group.dig('ProductCodes')
      product_types = product_codes.each do |code|
        product_type = ProductType.find_or_create_by!(code: code)

        group.discount_product_types.find_or_create_by!(product_type: product_type)
      end
    end
  end

  def self.remove_discount(raw_json)
    json = JSON.parse(raw_json)
    code = json.dig('Code')

    return unless discount = Discount.find_by(code: code)
    discount.last_checked = Time.current.utc
    discount.removed = true
    discount.save!
  end
end
