class Collection::Item < ApplicationRecord
  has_closure_tree order: 'sort_order' # , numeric_order: true
  include Collection::ItemRansack
  include Discard::Model

  has_many :fields, class_name: 'Collection::Field', foreign_key: :collection_item_id, inverse_of: :item
  belongs_to :creator, class_name: 'User'

  validates :label, presence: true
  validates :sort_order, presence: true, numericality: { only_integer: true },
                         uniqueness: { scope: %i[parent_id discarded_at] }

  scope :by_discarded, lambda { |v|
    case v
    when 'active'
      where(discarded_at: nil)
    when 'discarded'
      where.not(discarded_at: nil)
    end
  }

  def top_level?
    parent.blank?
  end

  def self.max_sort_order_by_level(parent_id)
    where(parent_id:).order(:sort_order).last&.sort_order.to_i
  end
end
