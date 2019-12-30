require 'rails_helper'

describe Articles::Operations::ImportArticlesByCategory do
  def get_nokogiri_story_data
    stub_request(
      :any,
      'https://opensource.googleblog.com/2019/09/unleashing-open-source-silicon.html'
    )
      .to_return(
      body: File.new(Rails.root + 'spec/support/test.html'), status: 200
    )
  end

  def get_story_ids_by_category
    stub_request(
      :get,
      'https://hacker-news.firebaseio.com/v0/topstories.json?print=pretty'
    )
      .to_return(body: [21_622_830].to_json, status: 200)
  end

  def get_story_info_by_story_id
    stub_request(
      :get,
      'https://hacker-news.firebaseio.com/v0/item/21622830.json?print=pretty'
    )
      .to_return(
      body: {
        "by": 'csantini',
        "descendants": 83,
        "id": 21_619_710,
        "kids": [21_623_378],
        "score": 147,
        "time": 1_574_594_434,
        "title": 'Why does F = ma?',
        "type": 'story',
        "url":
          'https://opensource.googleblog.com/2019/09/unleashing-open-source-silicon.html'
      }.to_json,
      status: 200
    )
  end

  it 'is successful' do
    get_story_ids_by_category
    get_story_info_by_story_id
    get_nokogiri_story_data

    expect {
      result = described_class.call(category_name: 'top')
      article = Article.last
      expect(result.success?).to eq(true)
      expect(article.author_name).to eq('csantini')
      expect(article.article_url).to eq(
        'https://opensource.googleblog.com/2019/09/unleashing-open-source-silicon.html'
      )
    }.to change { Article.count }.by(1)
  end
end
