class DonesController < ApplicationController
  def create
    @comment = Comment.new
    @done = Done.new
    @done.user = current_user
    experience = Experience.find(params[:experience_id])
    @done.experience = experience
    if params[:github_username]
      @user = User.find_by(github_username: params[:github_username])
    end
    authorize @done
    if @done.save
      respond_to do |format|
        format.html { redirect_to experiences_path }
        format.js
      end
    end
  end

  def destroy
    @done = Done.find(params[:id])
    @experience = @done.experience
    if params[:github_username]
      @user = User.find_by(github_username: params[:github_username])
    end
    authorize @done
    if @done.destroy
      respond_to do |format|
        format.html { redirect_to experiences_path }
        format.js
      end
    else
      respond_to do |format|
        format.js
      end
    end
  end

  def user_not_authorized(exception)
    policy_name = exception.policy.class.to_s.underscore
    render js: "alert('Sorry, you cannot delete your own experience.')"
  end
end
