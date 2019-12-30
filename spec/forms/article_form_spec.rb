require 'rails_helper'

describe ArticleForm do
  let(:article) { create(:article) }
  let(:new_article) { Article.new }
  let(:article_form) { ArticleForm.new(article) }

  # == Constants ============================================================

  # == Attributes ===========================================================

  # == Extensions ===========================================================

  # == Relationships ========================================================

  # == Validations ==========================================================

  # == Scopes ===============================================================

  # == Callbacks ============================================================

  # == Class Methods ========================================================

  # == Instance Methods =====================================================

  describe 'ArticleForm functionality' do
    it "will update existing article's top_story/best_story/new_story to true when same hackernews_article_id is found" do
      article_form = ArticleForm.new(article, { section: 'top' })
      article_form.save
      expect(article_form.errors.full_messages).to eq([])
      expect(article.top_story).to eq(true)
      article.reload

      article_form = ArticleForm.new(article, { section: 'best' })
      article_form.save
      expect(article_form.errors.full_messages).to eq([])
      expect(article.top_story).to eq(true)
      expect(article.best_story).to eq(true)
      article.reload
    end
  end
end
