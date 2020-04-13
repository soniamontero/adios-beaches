class DonesController < ApplicationController
  def create
    @comment = Comment.new
    @done = Done.new
    @done.user = current_user
    experience = Experience.find(params[:experience_id])
    @done.experience = experience
    # params[:github_username] are found only on user show page
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
    # params[:github_username] are found only on user show page
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

  # Method not used for now - to update.
  def user_not_authorized(exception)
    @error = true
    respond_to do |format|
        format.html {}
        format.js { render text: 'ici' }
      end
  end
end
