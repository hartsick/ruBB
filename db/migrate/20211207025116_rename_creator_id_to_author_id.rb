class RenameCreatorIdToAuthorId < ActiveRecord::Migration[6.1]
  def change
    rename_column :topics, :creator_id, :author_id
    add_reference :posts, :author, foreign_key: { to_table: :users }
  end
end
