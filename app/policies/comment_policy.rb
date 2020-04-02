class CommentPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    record.done.user == user && record.done.comment.id.nil?
  end

  def update?
    record.user == user
  end
end
