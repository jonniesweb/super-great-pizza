class ProductRepository
  def create(name:, code:)
    ProductType.create!(name: name, code: code)
  end

  def find_by_code(code)
    ProductType.find_by(code: code)
  end
end
