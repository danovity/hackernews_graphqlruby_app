class GraphQLSchema < GraphQL::Schema
  mutation(Types::MutationType)
  query(Types::QueryType)

  default_max_page_size 10
end
