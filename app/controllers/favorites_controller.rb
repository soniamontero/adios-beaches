class FavoritesController < ApplicationController
  def create
    @favorite = Favorite.new
    @favorite.user = current_user
    experience = Experience.find(params[:experience_id])
    @favorite.experience = experience
    if params[:github_username]
      @user = User.find_by(github_username: params[:github_username])
    end
    authorize @favorite
    if @favorite.save
      respond_to do |format|
        format.html { redirect_to experiences_path }
        format.js
      end
    end
    # if @favorite.save && params[:redirect_to] == "index"
    #   redirect_to experiences_path
    # elsif @favorite.save && params[:redirect_to] == 'show'
    #   redirect_to experience_path(experience)
    # elsif @favorite.save && params[:redirect_to].include?('profile')
    #   username = params[:redirect_to].split[1]
    #   redirect_to user_profile_path(username)
    # else
    #   redirect_back(fallback_location: root_path)
    # end
  end

  def destroy
    @favorite = Favorite.find(params[:id])
    experience = @favorite.experience
    if params[:github_username]
      @user = User.find_by(github_username: params[:github_username])
    end
    authorize @favorite
    @favorite.destroy
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

  private

  # def done_params
  #   params.require(:done).permit(:user_id, :redirect_to)
  # end
end
