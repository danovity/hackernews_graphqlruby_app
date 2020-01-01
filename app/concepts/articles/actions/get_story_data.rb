module Articles
  class Actions::GetStoryData
    extend LightService::Action
    expects :story_id
    promises :hackernews_story_data, :nokogiri_story_data

    executed do |context|
      begin
        story_id = context.story_id

        hackernews_story_data =
          Utils::ApiRequests.get_story_data(story_id: story_id)
        nokogiri_story_data =
          Nokogiri.HTML(
            open("#{hackernews_story_data.dig('url')}", 'User-Agent' => 'firefox')
          )
      rescue StandardError => e
        puts "Rescued: #{e.inspect}"
        context.skip_all!('Failed to retrieve story data')
      end

      if hackernews_story_data.blank? && nokogiri_story_data.blank?
        context.fail_and_return!('Failed to retrieve story data')
      end

      context.hackernews_story_data = hackernews_story_data
      context.nokogiri_story_data = nokogiri_story_data
    end
  end
end
