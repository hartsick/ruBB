class CreateProfiles < ActiveRecord::Migration[6.1]
  def change
    create_table :profiles do |t|
      t.text :about_me
      t.references :user

      t.timestamps
    end
  end
end
