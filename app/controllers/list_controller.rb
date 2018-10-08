class ListController < ApplicationController
  def index
    @discounts = Discount.all
  end
end
