module TopicHelper
    def unread_posts?(topic, views_for_topic)
        return true if views_for_topic.nil? || views_for_topic.none?
        topic.posts.last.created_at > views_for_topic.first.created_at
    end

    def unread_mentions?(mentions_for_topic, views_for_topic)
        return unless mentions_for_topic.present?
        return true unless views_for_topic.present?

        mentions_for_topic.first.created_at > views_for_topic.first.created_at
    end

    def format_body(post_body)
        return unless post_body

        post_body.gsub(UserMention.format_username_regex) {|mention| "<span class='font-bold'>#{mention}</span>" }.html_safe
    end
    
    def page_counter(total_amount, page, items_per_page)
        start_count = (page * items_per_page) + 1
        end_count = (page + 1) * items_per_page

        "#{start_count}-#{[total_amount,end_count].min} of #{total_amount}"
    end
end
