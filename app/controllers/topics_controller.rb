class TopicsController < ApplicationController
    before_action :authenticate_user!

    def index
        @topics = Topic.all.recently_updated
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
            redirect_to topic_path(@topic)
        else
            render :show
        end
    end

    private

    def topic_params
        params.require(:topic).permit(:title, posts_attributes: [:body])
    end
    
    def post_params
        params.require(:post).permit(:body)
    end
end
