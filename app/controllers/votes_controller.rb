class VotesController < ApplicationController
  def create
    @vote = Vote.new
    @vote.user = current_user
    @vote.value = params[:value]
    experience = Experience.find(params[:experience_id])
    @vote.experience = experience
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
    # if @vote.save && params[:redirect_to] == "index"
    #   redirect_to experiences_path
    # elsif @vote.save && params[:redirect_to] == 'show'
    #   redirect_to experience_path(experience)
    # elsif @vote.save && params[:redirect_to].include?('profile')
    #   username = params[:redirect_to].split[1]
    #   redirect_to user_profile_path(username)
    # else
    #   redirect_back(fallback_location: root_path)
    # end
  end

  def update
    @vote = Vote.find(params[:id])
    experience = @vote.experience
    if @vote.value == 1
      @vote.value = -1
    elsif @vote.value == -1
      @vote.value = 1
    end
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
    # if @vote.save && params[:redirect_to] == 'show'
    #   redirect_to experience_path(experience)
    # elsif @vote.save && params[:redirect_to] == "index"
    #   redirect_to experiences_path
    # else
    #   redirect_back(fallback_location: experiences_path)
    # end
  end

  def destroy
    @vote = Vote.find(params[:id])
    experience = @vote.experience
    if params[:github_username]
      @user = User.find_by(github_username: params[:github_username])
    end
    authorize @vote
    @vote.destroy
    respond_to do |format|
      format.html { redirect_to experiences_path }
      format.js
    end
    # if params[:redirect_to] == "index"
    #   redirect_to experiences_path
    # elsif params[:redirect_to] == 'show'
    #   redirect_to experience_path(experience)
    # elsif params[:redirect_to][0] == 'profile'
    #   username = params[:redirect_to][1]
    #   redirect_to user_profile_path(username)
    # else
    #   redirect_back(fallback_location: root_path)
    # end
  end
end
