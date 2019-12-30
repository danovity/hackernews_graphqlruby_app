TypesArticle::ArticleType =
  GraphQL::ObjectType.define do
    name 'Article'
    description 'A FlipGive Article.'

    field :id, !types.ID
    field :title, !types.String
    field :image_url, !types.String
    field :description, !types.String
    field :article_url, !types.String
    field :hackernews_article_id, !types.String
    field :slug, !types.String
    field :author_name, !types.String
    field :published_at, !types.String
  end
