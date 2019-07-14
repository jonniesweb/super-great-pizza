# typed: strict
module Types
  class StoreType < Types::BaseObject
    field :code, String, null: false
    field :city, String, null: true
    field :address, String, null: true
    field :json, String, null: false
    field :discounts, [DiscountType], null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
