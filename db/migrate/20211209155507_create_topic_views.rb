class CreateTopicViews < ActiveRecord::Migration[6.1]
  def change
    create_table :topic_views do |t|
      t.references :user
      t.references :topic

      t.timestamps
    end
  end
end
