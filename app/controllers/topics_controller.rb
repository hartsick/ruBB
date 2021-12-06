class TopicsController < ApplicationController
    before_action :authenticate_user!

    def index
        @topics = Topic.all.order("created_at DESC")
    end

    def new
        @topic = Topic.new
    end

    def create
        @topic = Topic.new(topic_params)
        @topic.created_at = Time.now
        @topic.creator = current_user

        if @topic.valid?
            @topic.save
            redirect_to topic_path(@topic)
        else
            render :new
        end
    end

    def show
        @topic = Topic.find(params[:id])
    end

    private

    def topic_params
        params.require(:topic).permit(:title, :body)
    end
end
