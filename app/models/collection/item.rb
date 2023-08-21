class Collection::Item < ApplicationRecord
  include Collection::ItemRansack
  include Discard::Model

  belongs_to :creator, class_name: 'User'
  belongs_to :parent, class_name: 'Collection::Item', optional: true
  has_many :children, class_name: 'Collection::Item', foreign_key: 'parent_id', inverse_of: :parent

  validates :label, presence: true

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
end
