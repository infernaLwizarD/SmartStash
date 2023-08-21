class CreateCollectionItems < ActiveRecord::Migration[6.1]
  def change
    create_table :collection_items do |t|
      t.string :label
      t.references :creator, null: false, foreign_key: { to_table: :users }
      t.integer :parent_id
      t.integer :sort_order, null: false, default: 0

      t.timestamps
      t.datetime :discarded_at, index: true
    end
  end
end
