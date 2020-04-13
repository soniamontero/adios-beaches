class VotesController < ApplicationController
  def create
    @vote = Vote.new
    @vote.user = current_user
    @vote.value = params[:value]
    experience = Experience.find(params[:experience_id])
    @vote.experience = experience
    # params[:github_username] are found only on user show page
    if params[:github_username]
      @user = User.find_by(github_username: params[:github_username])
    end
    authorize @vote
    if @vote.save
      respond_to do |format|
        format.html { redirect_to experiences_path }
        format.js
      end
    end
  end

  def update
    @vote = Vote.find(params[:id])
    experience = @vote.experience

    # Very advanced maths here.
    if @vote.value == 1
      @vote.value = -1
    elsif @vote.value == -1
      @vote.value = 1
    end
    # params[:github_username] are found only on user show page
    if params[:github_username]
      @user = User.find_by(github_username: params[:github_username])
    end
    authorize @vote
    if @vote.save
      respond_to do |format|
        format.html { redirect_to experiences_path }
        format.js
      end
    end
  end

  def destroy
    @vote = Vote.find(params[:id])
    experience = @vote.experience
    # params[:github_username] are found only on user show page
    if params[:github_username]
      @user = User.find_by(github_username: params[:github_username])
    end
    authorize @vote
    @vote.destroy
    respond_to do |format|
      format.html { redirect_to experiences_path }
      format.js
    end
  end
end
