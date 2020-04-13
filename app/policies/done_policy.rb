class DonePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    true
  end

  # Ensure that user doesn't destroy the done of their own experience.
  def destroy?
    record.user == user && record.experience.user != user
  end
end
