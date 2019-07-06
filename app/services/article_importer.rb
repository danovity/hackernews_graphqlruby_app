require 'nokogiri'
require 'open-uri'

class ArticleImporter
  include HTTParty
  base_uri 'https://hacker-news.firebaseio.com/v0'

  def self.import_all_articles
    importer = self.new
    importer.import_top_story_ids
    importer.import_new_story_ids
    importer.import_best_story_ids
  end

  def import_top_story_ids
    top_story_ids = self.class.get("/topstories.json?print=pretty")
    create_articles(top_story_ids, "top")
  end

  def import_new_story_ids
    new_story_ids = self.class.get("/newstories.json?print=pretty")
    create_articles(new_story_ids, "new")
  end

  def import_best_story_ids
    best_story_ids = self.class.get("/beststories.json?print=pretty")
    create_articles(best_story_ids, "best")
  end

  private

  def create_articles(story_ids, story_type)
    story_ids.each do |story_id|
      begin
        hackernews_story_data = self.class.get("/item/#{story_id}.json?print=pretty")
        nokogiri_story_data = Nokogiri::HTML(open("#{hackernews_story_data.dig("url")}", 'User-Agent' => 'firefox'))
        next if hackernews_story_data.blank? && nokogiri_story_data.blank?

        params = parse_params(hackernews_story_data, nokogiri_story_data, story_type)
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

  def parse_params(hn_data, nk_data, story_type)
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

  def get_article_image_url(nk_data)
    return 'https://picsum.photos/200/300?grayscale' if nk_data.at("meta[property='og:image']").blank?
    nk_data.at("meta[property='og:image']")["content"]
  end

  def get_description(nk_data)
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
