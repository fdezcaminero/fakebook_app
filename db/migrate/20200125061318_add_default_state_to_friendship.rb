class AddDefaultStateToFriendship < ActiveRecord::Migration[5.2]
  def change
    change_column_default :friendships, :status, 0
    change_column_null :friendships, :status, false
  end
end
