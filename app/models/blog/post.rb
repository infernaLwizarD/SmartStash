class Blog::Post < ApplicationRecord
  include Blog::PostRansack
  include Discard::Model

  belongs_to :creator, class_name: 'User'

  validates :label, presence: true
end
