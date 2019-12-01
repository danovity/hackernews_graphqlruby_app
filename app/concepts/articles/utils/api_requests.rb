require 'nokogiri'
require 'open-uri'

module Articles
  class Utils::ApiRequests
    include HTTParty
    base_uri 'https://hacker-news.firebaseio.com/v0'
    format :json

    def self.get_story_ids_by_category(category_name:)
      get("/#{category_name}stories.json?print=pretty")
    end

    def self.get_story_data(story_id:)
      get("/item/#{story_id}.json?print=pretty")
    end
  end
end
