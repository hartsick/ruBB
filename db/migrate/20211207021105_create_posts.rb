class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.text :body
      t.references :topic, foreign_key: true

      t.timestamps
    end

    remove_column :topics, :body, :text
  end
end
