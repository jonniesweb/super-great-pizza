# typed: ignore
module Types
  class DiscountType < Types::BaseObject
    field :code, String, null: false
    field :name, String, null: false
    field :json, String, null: false
    field :product_groups, [ProductGroupType], null: false
    field :last_checked, GraphQL::Types::ISO8601DateTime, null: false
    field :price, String, null: true
    field :removed, Boolean, null: false
    field :store, StoreType, null: false
    field :image_url, String, null: true
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false

    def product_groups
      object.discount_product_type_groups
    end
  end
end
