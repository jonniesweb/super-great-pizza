module Types
  class ProductGroupType < Types::BaseObject
    field :group_type, GroupType, null: false
    field :required_quantity, Integer, null: false
    field :products, [ProductType], null: false
    field :discount, DiscountType, null: false
    field :max_quantity, Integer, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false

    def group_type
      return 'NONE' unless object.group_type
      object.group_type.upcase
    end

    def products
      object.product_types
    end
  end
end
