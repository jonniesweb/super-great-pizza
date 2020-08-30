# typed: true
class ListController < ApplicationController
  def index
    @q = Discount.ransack(params[:q])
    @discounts = @q.result(distinct: true).includes(:products, :discount_product_type_groups, :store)
  end
end
