class Collection::ItemPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index?
    true
  end

  def show?
    true
  end

  def create?
    if record.instance_of?(Collection::Item)
      if record.top_level?
        record.kept?
      else
        record.kept? && record.parent.kept?
      end
    else
      true
    end
  end

  def update?
    record.kept? && if user.admin?
                      true
                    else
                      record.creator_id == user.id
                    end
  end

  def destroy?
    record.kept? && if user.admin?
                      true
                    else
                      record.creator_id == user.id
                    end
  end

  def restore?
    record.discarded? && if user.admin?
                           true
                         else
                           record.creator_id == user.id
                         end
  end
end
