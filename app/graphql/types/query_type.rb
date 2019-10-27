# typed: ignore
module Types
  class QueryType < Types::BaseObject
    field :store_by_code, StoreType, null: true do
      argument :code, String, required: true
    end

    field :stores, [StoreType], null: false

    def store_by_code(code:)
      Store.find_by(code: code)
    end

    def stores
      Store.all
    end
  end
end
