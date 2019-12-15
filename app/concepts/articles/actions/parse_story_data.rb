module Articles
  class Actions::ParseStoryData
    extend LightService::Action
    expects :hackernews_story_data, :nokogiri_story_data, :category_name
    promises :parsed_story_params

    executed do |context|
      category_name = context.category_name
      nk_data = context.nokogiri_story_data
      hn_data = context.hackernews_story_data

      description = get_description(nk_data)
      slug = hn_data["title"].parameterize.underscore
      image_url = get_article_image_url(nk_data)

      parsed_story_params = {
        title: hn_data[ "title" ],
        author_name: hn_data[ "by" ],
        published_at: Time.at(hn_data[ "time" ]),
        description: description,
        image_url: image_url,
        article_url: hn_data[ "url" ],
        hackernews_article_id: hn_data[ "id" ],
        slug: slug,
        section: category_name,
        kids: hn_data["kids"],
        score: hn_data["score"]
      }

      if parsed_story_params.blank?
        context.fail_and_return!("Failed to parse story data")
      end

      context.parsed_story_params = parsed_story_params
    end

    def self.get_article_image_url(nk_data)
      return 'https://picsum.photos/200/300?grayscale' if nk_data.at("meta[property='og:image']").blank?

      nk_data.at("meta[property='og:image']")["content"]
    end

    def self.get_description(nk_data)
      description =
        if nk_data.at("meta[name='description']")
          nk_data.at("meta[name='description']")["content"]
        elsif nk_data.at("meta[property='og:description']")
          nk_data.at("meta[property='og:description']")["content"]
        elsif nk_data.css('p.description')[0]
          nk_data.css('p.description')[0].text
        else
          BetterLorem.w(20, true)
        end
    end
  end
end
