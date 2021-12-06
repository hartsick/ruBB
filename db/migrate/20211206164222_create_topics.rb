class CreateTopics < ActiveRecord::Migration[6.1]
  def change
    create_table :topics do |t|
      t.string :title
      t.text :body
      t.references :creator, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
