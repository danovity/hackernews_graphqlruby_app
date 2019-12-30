require 'rails_helper'

RSpec.describe Article, type: :model do
  describe '#validations' do
    it 'should test that the factory is valid' do
      expect(build :article).to be_valid
    end

    it 'should validate the presence of the title' do
      article = build :article, title: ''
      expect(article).not_to be_valid
      expect(article.errors.messages[:title]).to include("can't be blank")
    end

    it 'should validate the presence of the author_name' do
      article = build :article, author_name: ''
      expect(article).not_to be_valid
      expect(article.errors.messages[:author_name]).to include("can't be blank")
    end

    it 'should validate the presence of the published_at' do
      article = build :article, published_at: ''
      expect(article).not_to be_valid
      expect(article.errors.messages[:published_at]).to include(
        "can't be blank"
      )
    end

    it 'should validate the presence of the slug' do
      article = build :article, slug: ''
      expect(article).not_to be_valid
      expect(article.errors.messages[:slug]).to include("can't be blank")
    end

    it 'should validate uniqueness of the slug' do
      article = create :article
      invalid_article = build :article, slug: article.slug
      expect(invalid_article).not_to be_valid
    end

    it 'should validate uniqueness of the hackernews_article_id' do
      article = create :article
      invalid_article =
        build :article,
              slug: 'new_slug',
              hackernews_article_id: article.hackernews_article_id
      expect(invalid_article).not_to be_valid
    end
  end
end
