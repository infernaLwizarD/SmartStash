class CreateCollectionFields < ActiveRecord::Migration[6.1]
  def change
    create_table :collection_fields do |t|
      t.references :collection_item, null: false, foreign_key: { to_table: :collection_items }
      t.references :creator, null: false, foreign_key: { to_table: :users }
      t.integer :sort_order, null: false, default: 0
      t.text :field_attributes

      t.timestamps
      t.datetime :discarded_at, index: true
    end
  end
end
