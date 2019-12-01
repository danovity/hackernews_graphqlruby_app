module Articles
  class Actions::CreateArticles
    extend LightService::Action
    expects :story_ids, :category_name

    executed do |context|
      context.story_ids.each do |story_id|
        begin
          hackernews_story_data = Utils::ApiRequests.get_story_data(story_id: story_id)
          nokogiri_story_data = Nokogiri::HTML(open("#{hackernews_story_data.dig("url")}", 'User-Agent' => 'firefox'))
          next if hackernews_story_data.blank? && nokogiri_story_data.blank?

          params = parse_params(hackernews_story_data, nokogiri_story_data, context.category_name)
          next if params.blank?

          article = Article.find_by(hackernews_article_id: hackernews_story_data["id"])

          if article.present?
            form = ArticleForm.new(article, params)
          else
            form = ArticleForm.new(Article.new, params)
          end

          form.save
        rescue Exception => error
          puts "Error"
        end
      end
    end

    def self.parse_params(hn_data, nk_data, story_type)
      description = get_description(nk_data)
      slug = hn_data["title"].parameterize.underscore
      image_url = get_article_image_url(nk_data)

      @params = {
        title: hn_data[ "title" ],
        author_name: hn_data[ "by" ],
        published_at: Time.at(hn_data[ "time" ]),
        description: description,
        image_url: image_url,
        article_url: hn_data[ "url" ],
        hackernews_article_id: hn_data[ "id" ],
        slug: slug,
        section: story_type,
        kids: hn_data["kids"],
        score: hn_data["score"]
      }
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

