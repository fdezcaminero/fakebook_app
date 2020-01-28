class AddFriendshipsColumnToFriendships < ActiveRecord::Migration[5.2]
  def change
    add_column :friendships, :relation, :string
    add_index :friendships, :relation, unique: true
  end
end
