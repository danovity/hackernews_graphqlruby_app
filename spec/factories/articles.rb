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

    factory :new_story do
      best_story {false}
      new_story {true}
      top_story {false}
    end
    factory :best_story do
      top_story {false}
      best_story {true}
      new_story {false}
    end
    factory :top_story do
      top_story {true}
      best_story {false}
      new_story {false}
    end
    factory :top_and_new_story do
      sequence(:author_name) { |n| "top_and_new_stories_#{n}" }
      top_story {true}
      new_story {true}
      best_story {false}
    end
    factory :best_and_new_story do
      sequence(:author_name) { |n| "best_and_new_stories_#{n}" }
      new_story {true}
      best_story {true}
      top_story {false}
    end
  end
end
