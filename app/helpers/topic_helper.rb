module TopicHelper
    def unread_posts?(topic, topic_views)
        return true if topic_views[topic.id].nil? || topic_views[topic.id].none?
        topic.posts.last.created_at > topic_views[topic.id].first.created_at
    end

    def mentions_in_thread?(topic, mentions)
        mentions[topic.id] && mentions[topic.id].any?
    end
end
