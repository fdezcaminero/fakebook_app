class CreateFriendships < ActiveRecord::Migration[5.2]
  def change
    create_table :friendships do |t|
      t.integer :status
      t.references :requester, null: false, foreign_key: { to_table: :users}
      t.references :requestee, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
    add_index :friendships, :requester_id, name: 'requester_id_index'
    add_index :friendships, :requestee_id, name: 'requestee_id_index'
  end
end
