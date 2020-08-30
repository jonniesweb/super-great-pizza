class DiscountRepository
  def find_by_code(store_code, discount_code)
    return nil unless store = Store.find_by(code: store_code)
    
    Discount.find_by(store: store, code: discount_code)
  end

  def save(discount)
    discount.save!
  end

  def init(attrs)
    Discount.new(attrs)
  end

  def update_product_type_groups(discount, new_product_type_groups)
    current_groups = discount.discount_product_type_groups
    current_group_types = current_groups.map(&:group_type)

    new_product_type_groups
  end

  def one
    d = Discount.find_or_initialize_by(name: 'one', code: '321', store_id: 1)

    a = DiscountProductTypeGroup.new(discount: d, group_type: 'ONE')
    b = DiscountProductTypeGroup.new(discount: d, group_type: 'ANOTHER')

    d.discount_product_type_groups = [a,b]

    d.save!
  end
end
