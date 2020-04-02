class DonePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    true
  end

  def destroy?
    unless record.user == user && record.experience.user != user
      @error_message = "This is your own experience, you can't delete it."
      false
    end
  end
end
