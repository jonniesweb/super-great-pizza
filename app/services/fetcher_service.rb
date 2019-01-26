class FetcherService
  include ApiHelper

  THREAD_POOL_SIZE = 10
  DEFAULT_STORE = 10503
  HOST = 'order.dominos.ca'

  def self.call(store_id = DEFAULT_STORE)
    new.call(store_id)
  end

  def call(store_id = DEFAULT_STORE)
    range = 3000..20000
    range.each do |code|
      FetchDiscountJob.perform_later(code, store_id)
    end

    Store.find_by(code: store_id)
      .discounts
      .pluck(:code)
      .reject { |existing_code| range === existing_code }
      .each { |existing_code| FetchDiscountJob.perform_later(existing_code, store_id) }
  end

  def self.run(code, store_id = DEFAULT_STORE)
    new.run(code, store_id)
  end
  
  def run(code, store_id = DEFAULT_STORE)
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

  def test_one
    process_discount(Discount.find_by(id: 41).json)
  end

  def reprocess_all
    Discount.all.each do |discount|
      process_discount(discount.json)
    end
  end

  def query_api(host, store_id, discount_code)
    query("https://#{host}/power/store/#{store_id}/coupon/#{discount_code}?lang=en")
  end

  def process_discount(raw_json)
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
    discount.last_checked = Time.current.utc
    discount.price = json.dig('Price')
    discount.store = Store.find_by(code: json.dig('StoreID'))
    discount.removed = false
    discount.image_url = image_url(json)
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

  def remove_discount(raw_json)
    json = JSON.parse(raw_json)
    code = json.dig('Code')

    return unless discount = Discount.find_by(code: code)
    discount.last_checked = Time.current.utc
    discount.removed = true
    discount.save!
  end

  def image_url(json)
    code = json.dig('ImageCode')
    "https://cache.dominos.com/nolo/ca/en/054113/assets/build/market/CA/_en/images/img/coupons/thumbnails/#{code}.jpg"
  end
end
