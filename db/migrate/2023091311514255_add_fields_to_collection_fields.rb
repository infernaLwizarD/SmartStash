class AddFieldsToCollectionFields < ActiveRecord::Migration[6.1]
  def up
    rename_column :collection_fields, :field_attributes, :field_values
    change_column_default :collection_fields, :field_values, [].to_yaml
    add_column :collection_fields, :label, :string
    add_column :collection_fields, :show_tooltip, :boolean, default: false, null: false
    add_column :collection_fields, :tooltip, :string
    add_column :collection_fields, :is_numeric, :boolean, default: false, null: false
    add_column :collection_fields, :no_format, :boolean, default: false, null: false
    add_column :collection_fields, :precision, :integer
    add_column :collection_fields, :min_value, :integer
    add_column :collection_fields, :max_value, :integer
    add_column :collection_fields, :step, :integer
    add_column :collection_fields, :default_value, :string
  end

  def down
    rename_column :collection_fields, :field_values, :field_attributes
    change_column_default :collection_fields, :field_attributes, nil
    remove_column :collection_fields, :label, :string
    remove_column :collection_fields, :show_tooltip, :boolean, default: false, null: false
    remove_column :collection_fields, :tooltip, :string
    remove_column :collection_fields, :is_numeric, :boolean, default: false, null: false
    remove_column :collection_fields, :no_format, :boolean, default: false, null: false
    remove_column :collection_fields, :precision, :integer
    remove_column :collection_fields, :min_value, :integer
    remove_column :collection_fields, :max_value, :integer
    remove_column :collection_fields, :step, :integer
    remove_column :collection_fields, :default_value, :string
  end
end
