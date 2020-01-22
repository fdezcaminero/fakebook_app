class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.resources :user
      t.text :content
      t.text :picture

      t.timestamps
    end
  end
end
