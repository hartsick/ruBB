class CreateTopicFollows < ActiveRecord::Migration[6.1]
  def change
    create_table :topic_follows do |t|
      t.references :user
      t.references :topic
      
      t.timestamps
    end
  end
end
