# typed: false
module Types
  class QueryType < Types::BaseObject
    field :store_by_code, StoreType, null: true do
      argument :code, String, required: true
    end

    def store_by_code(code:)
      Store.find_by(code: code)
    end
  end
end
