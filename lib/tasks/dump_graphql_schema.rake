require "graphql/rake_task"

graphql_task = GraphQL::RakeTask.new(
  schema_name: "SuperGreatPizzaSchema",
  dependencies: [:environment],
  directory: 'config/schemas'
)