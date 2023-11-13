class CreateBlogPosts < ActiveRecord::Migration[6.1]
  def change
    create_table :blog_posts do |t|
      t.string :label
      t.text :description
      t.text :message
      t.references :creator, null: false, foreign_key: { to_table: :users }

      t.timestamps
      t.datetime :discarded_at, index: true
    end
  end
end
