class Topic < ApplicationRecord
    has_many :posts, -> { order(created_at: :asc) }
    has_many :topic_views

    belongs_to :author, class_name: 'User', inverse_of: :created_topics

    accepts_nested_attributes_for :posts

    validates_presence_of :title, :author

    scope :updated_today, -> {
        subquery = Post.select(:id)
                       .where("posts.topic_id = topics.id")
                       .order(created_at: :desc).limit(1)
      
        joins(<<-SQL).where('posts.created_at >= ?', sunrise).order('posts.created_at DESC')
          LEFT JOIN posts
            ON posts.topic_id = topics.id
            AND posts.id = (#{subquery.to_sql})
        SQL
      }

    scope :updated_before, -> {
        subquery = Post.select(:id)
                       .where("posts.topic_id = topics.id")
                       .order(created_at: :desc).limit(1)
      
        joins(<<-SQL).where('posts.created_at < ?', sunrise).order('posts.created_at DESC')
          LEFT JOIN posts
            ON posts.topic_id = topics.id
            AND posts.id = (#{subquery.to_sql})
        SQL
      }

    def self.sunrise
        # ~midnight Pacific / 8am London
        DateTime.
            now.
            localtime(ActiveSupport::TimeZone.new("Pacific Time (US & Canada)")).
            beginning_of_day
    end
end
