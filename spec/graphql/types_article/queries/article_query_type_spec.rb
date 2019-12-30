require 'spec_helper'

describe GraphQLSchema do
  let(:type) { GraphQLSchema.types['Query'] }
  let(:query) { type.fields['Article'] }

  def create_articles
    top_and_new_stories = create_list(:top_and_new_story, 6)
    best_and_new_stories = create_list(:best_and_new_story, 6)
  end

  describe 'it queries the top stories' do
    let(:query_string) do
      "{
        (id: \"#{
        occasion.id
      }\") {
          id
          collections(first: 2){
            edges{
              cursor
              node{
                id
                name
              }
            }
            pageInfo{
              hasNextPage
              endCursor
            }
          }
        }
      }"
    end

    let(:context) do
      {
        current_user: user,
        campaign: campaign,
        currency: campaign.currency,
        site_id: campaign.site_id
      }
    end

    let(:result) do
      GraphQLSchema.execute(query_string, context: context, variables: {})
    end

    xit 'is successful' do
      create_occasion_collections
      create_collection_links

      context = { current_user: user, currency: 'CAD', campaign: campaign }

      has_next_page =
        result.dig('data', 'Occasion', 'collections', 'pageInfo', 'hasNextPage')
      brands_returned =
        result.dig('data', 'Occasion', 'collections', 'edges').count

      expect(brands_returned).to eq(2)
      expect(has_next_page).to eq(true)
    end
  end
end
