class RefreshesController < ApplicationController
  def show
  end

  def discount
    store_id = params.fetch(:store_id)
    code = params.fetch(:code)
    FetchDiscountJob.perform_later(code, store_id)
    redirect_to refresh_path
  end

  def store
    store_id = params.fetch(:store_id)
    Fetchers::StoreService.call(store_id)
    redirect_to refresh_path
  end

  def all
    Discount.pluck(:code, :store_id).each do |code, store_id|
      FetchDiscountJob.perform_later(code, store_id)
    end
    redirect_to refresh_path
  end

  def soft_all
    Discount.pluck(:json).each do |json|
      FetcherService.new.process_discount(json)
    end
    redirect_to refresh_path
  end
end
