class ProductRepository
  def create(name:, code:)
    Product.create!(name: name, code: code)
  end

  def find_by_code(code)
    Product.find_by(code: code)
  end
end
