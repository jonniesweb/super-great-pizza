# typed: strict
class SuperGreatPizzaSchema < GraphQL::Schema
  mutation(Types::MutationType)
  query(Types::QueryType)
end
