class Collection::Value < ApplicationRecord
  include Discard::Model

  belongs_to :item, class_name: 'Collection::Item', foreign_key: :collection_item_id, inverse_of: :values
  belongs_to :field, class_name: 'Collection::Field', foreign_key: :collection_field_id, inverse_of: :values
  belongs_to :creator, class_name: 'User'

  has_one_attached :file
end
