class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    @comment.user = current_user
    @comment.done = Done.find(params[:done_id].to_i)
    @experience = @comment.done.experience
    authorize @comment
    if @comment.save!
      respond_to do |format|
        format.html { redirect_to :back }
        format.js
      end
    else
      respond_to do |format|
        format.html { redirect_to :back }
        format.js
      end
    end
  end

  def edit
    @comment = Comment.find(params[:id])
    authorize @comment
    respond_to do |format|
      format.html { redirect_to :back }
      format.js
    end
  end

  def update
    @comment = Comment.find(params[:id])
    authorize @comment
    @comment.update(comment_params)
    respond_to do |format|
      format.html { redirect_to :back }
      format.js
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:description)
  end
end


