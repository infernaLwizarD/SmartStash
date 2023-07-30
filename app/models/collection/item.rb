class Collection::Item < ApplicationRecord
  include Collection::ItemRansack
  include Discard::Model

  belongs_to :creator, class_name: 'User'

  validates :label, presence: true

  scope :by_discarded, lambda { |v|
    case v
    when 'active'
      where(discarded_at: nil)
    when 'discarded'
      where.not(discarded_at: nil)
    end
  }
end
