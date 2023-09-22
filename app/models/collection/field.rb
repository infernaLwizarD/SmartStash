class Collection::Field < ApplicationRecord
  include Discard::Model
  include Collection::FieldRansack
  include Collection::FieldEnum

  belongs_to :item, class_name: 'Collection::Item', foreign_key: :collection_item_id, inverse_of: :fields
  belongs_to :creator, class_name: 'User'

  serialize :field_values, Array

  def field_values=(value)
    value = value.split(/[\r\n]+/).compact if value.is_a?(String)
    super(value)
  end

  scope :by_discarded, lambda { |v|
    case v
    when 'active'
      where(discarded_at: nil)
    when 'discarded'
      where.not(discarded_at: nil)
    end
  }

  def self.max_sort_order_by_item(collection_item_id)
    where(collection_item_id:).order(:sort_order).last&.sort_order.to_i
  end
end
