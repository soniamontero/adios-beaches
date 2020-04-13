class CommentPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  # Ensure that user posting comment has also a done on that same experience.
  def create?
    record.done.user == user && record.done.comment.id.nil?
  end

  def update?
    record.user == user
  end
end
