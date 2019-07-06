FactoryBot.define do
  factory :article do
    author_name { "MyString" }
    description { "MyString" }
    published_at { "2019-06-19 06:57:48" }
    title { "MyString" }
    article_url { "MyString" }
    slug { "MyString" }
    hackernews_article_id { 123 }
    image_url {"imageurl.com"}
  end
end
