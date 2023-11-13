module Blog::PostRansack
  extend ActiveSupport::Concern

  included do
    ransack_alias :search, :label
  end

  class_methods do
    def ransackable_attributes(_auth_object = nil)
      %w[search label]
    end

    def ransackable_associations(_auth_object = nil)
      []
    end

    def ransackable_scopes(_auth_object = nil)
      []
    end
  end
end
