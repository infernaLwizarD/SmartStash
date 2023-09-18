class AddFieldTypeToCollectionFields < ActiveRecord::Migration[6.1]
  def up
    execute <<~SQL.squish
      CREATE TYPE item_field_type AS ENUM ('text', 'textarea', 'select', 'date', 'checkbox', 'radio', 'file');
    SQL
    add_column :collection_fields, :field_type, :item_field_type
  end

  def down
    remove_column :collection_fields, :field_type
    execute <<~SQL.squish
      DROP TYPE item_field_type;
    SQL
  end
end
