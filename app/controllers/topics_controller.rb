class TopicsController < ApplicationController
    after_action :log_topic_view, only: %i[show create update]

    def index
        @topics = Topic.all.by_most_recent_post
        setup_for_topics!(@topics)
    end

    def new
        @topic = Topic.new
        @topic.posts.build
    end

    def create
        @topic = Topic.new(topic_params)
        @topic.created_at = Time.now
        @topic.author = current_user
        @topic.posts.first.author = current_user

        if @topic.save
            UserMention.associate_mentions_in_post!(@topic.posts.first)
            redirect_to topic_path(@topic)
        else
            render :new
        end
    end

    def show
        @topic = Topic.find(params[:id])
        @new_post = @topic.posts.build
    end

    def update
        @topic = Topic.find(params[:id])
        @new_post = @topic.posts.build(post_params)
        @new_post.author = current_user

        if @new_post.save
            UserMention.associate_mentions_in_post!(@new_post)
            redirect_to topic_path(@topic)
        else
            render :show
        end
    end

    def star
        @topic = Topic.find(params[:topic_id])
        TopicFollow.create(topic: @topic, user: current_user)

        redirect_to topic_path(@topic)
    end

    def unstar
        @topic = Topic.find(params[:topic_id])
        topic_follows = TopicFollow.where(topic: @topic, user: current_user)
        topic_follows.delete_all

        redirect_to topic_path(@topic)
    end

    def mentions
        mentioned_posts = Post.includes(:user_mentions).where(user_mentions: { user_id: current_user.id })
        @topics = Topic.where(posts: mentioned_posts).by_most_recent_post
        setup_for_topics!(@topics)
    end

    def starred
        @topics = Topic.includes(:topic_follows).where(topic_follows: { user: current_user }).by_most_recent_post
        setup_for_topics!(@topics)
    end

    private

    def topic_params
        params.require(:topic).permit(:title, posts_attributes: [:body])
    end
    
    def post_params
        params.require(:post).permit(:body)
    end

    def log_topic_view
        TopicView.create(user: current_user, topic: @topic)
    end

    def setup_for_topics!(topics)
        @topic_follows = TopicFollow.where(user: current_user).where(topic: topics).order('created_at DESC').group_by{|tv| tv.topic_id }
        @topic_views = TopicView.where(user: current_user).where(topic: topics).order('created_at DESC').group_by{|tv| tv.topic_id }
        @mentions = UserMention.where(user: current_user).includes(:post).where(post: { topic: topics }).order('user_mentions.created_at DESC').group_by{|um| um.post.topic_id }
    end
end
