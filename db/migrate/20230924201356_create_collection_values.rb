class CreateCollectionValues < ActiveRecord::Migration[6.1]
  def change
    create_table :collection_values do |t|
      t.references :collection_item, null: false, foreign_key: { to_table: :collection_items }
      t.references :collection_field, null: false, foreign_key: { to_table: :collection_fields }
      t.references :creator, null: false, foreign_key: { to_table: :users }
      t.text :value

      t.timestamps
      t.datetime :discarded_at, index: true
    end
  end
end
