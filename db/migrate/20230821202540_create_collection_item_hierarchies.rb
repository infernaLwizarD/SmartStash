class CreateCollectionItemHierarchies < ActiveRecord::Migration[6.1]
  def change
    create_table :collection_item_hierarchies, id: false do |t|
      t.integer :ancestor_id, null: false
      t.integer :descendant_id, null: false
      t.integer :generations, null: false
    end

    add_index :collection_item_hierarchies, %i[ancestor_id descendant_id generations],
              unique: true,
              name: 'item_anc_desc_idx'

    add_index :collection_item_hierarchies, [:descendant_id], name: 'item_desc_idx'
  end
end
