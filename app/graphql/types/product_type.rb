# typed: ignore
module Types
  class ProductType < Types::BaseObject
    field :name, String, null: false
    field :code, String, null: false
    field :product_groups, [ProductGroupType], null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false

    def product_groups
      object.discount_product_type_groups
    end
  end
end
