class CreateArticles < ActiveRecord::Migration[5.2]
  def change
    create_table :articles do |t|
      t.string :author_name
      t.string :image_url
      t.string :description
      t.datetime :published_at
      t.string :title
      t.string :article_url
      t.string :slug
      t.integer :hackernews_article_id
      t.boolean :deleted, default: false
      t.string :descendants
      t.string :kids
      t.integer :score
      t.string :article_type
      t.string :type
      t.boolean :top_story, default: false
      t.boolean :best_story, default: false
      t.boolean :new_story, default: false

      t.timestamps
    end
  end
end
