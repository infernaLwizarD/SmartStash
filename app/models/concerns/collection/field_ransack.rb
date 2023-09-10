module Collection::FieldRansack
  extend ActiveSupport::Concern

  class_methods do
    def ransackable_attributes(_auth_object = nil)
      %w[field_type search id sort_order]
    end

    def ransackable_associations(_auth_object = nil)
      []
    end

    def ransackable_scopes(_auth_object = nil)
      ['by_discarded']
    end
  end
end
