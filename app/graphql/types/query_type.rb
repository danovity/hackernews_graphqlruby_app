# module Types
#   class QueryType < Types::BaseObject
#     # Add root-level fields here.
#     # They will be entry points for queries on your schema.

#     field :allArticles, [TypesArticle::ArticleType], "All articles", null: false

#     def all_articles
#       Article.all
#     end

#     # TODO: remove me
#     field :test_field, String, null: false,
#       description: "An example field added by the generator"
#     def test_field
#       "Hello World!"
#     end
#   end
# end

Types::QueryType =
  GraphQL::ObjectType.define do
    name 'Query'

    fields GraphQLUtils::FieldCombiner.combine(
             [TypesArticle::Queries::ArticleQueryType]
           )
  end
