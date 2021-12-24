class CreateUserMentions < ActiveRecord::Migration[6.1]
  def change
    create_table :user_mentions do |t|
      t.references :user
      t.references :post

      t.timestamps
    end
  end
end
