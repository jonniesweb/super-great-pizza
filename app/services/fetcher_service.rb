class FetcherService
  THREAD_POOL_SIZE = 10
  def call
    thread_pool = Concurrent::FixedThreadPool.new(THREAD_POOL_SIZE)
    discounts = Concurrent::Array.new

    range = 3000..20000
    range.each do |code|
      thread_pool.post(code) do |code|
        result = run(code)
        discounts << result if result
        true
      end
    end

    terminated = false
    while thread_pool.queue_length > 0
      puts "waiting 5 seconds for threads to finish. Current queue length: #{thread_pool.queue_length}"
      terminated = thread_pool.wait_for_termination(5)

      puts "saving discounts of size #{discounts.size}"
      discounts_to_save = discounts.pop(discounts.size)
      discounts_to_save.each(&:save!)
    end

    puts 'shutting down thread pool'
    thread_pool.shutdown
    thread_pool.wait_for_termination(5)

    save_discounts(discounts)
  end

  private

  def run(code)
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
    discount = nil

    if response.code == '404'
      # code doesn't exist
    elsif response.code == '200'
      json = JSON.parse(response.body)
      code = json.dig('Code')
      name = json.dig('Name')

      puts("found discount code: #{code}, name: #{name}")
      discount = Discount.new(json: json, code: code, name: name)
    else
      json = JSON.parse(response.body)
      puts "unexpected response: #{response.code}"
      puts json.inspect
    end
    puts "finish #{code}-#{response.code} in #{(Time.now - time).seconds}"

    discount
  end

  def save_discounts(discounts)
    puts "saving #{discounts.size} discounts"
    discounts.each(:save!)
  end
end
