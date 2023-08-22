module Collection::ItemRansack
  extend ActiveSupport::Concern

  included do
    ransack_alias :search, :label
  end

  class_methods do
    def ransackable_attributes(_auth_object = nil)
      %w[search label parent_id id sort_order]
    end

    def ransackable_associations(_auth_object = nil)
      []
    end

    def ransackable_scopes(_auth_object = nil)
      ['by_discarded']
    end
  end
end
