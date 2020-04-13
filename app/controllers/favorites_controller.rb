class FavoritesController < ApplicationController
  def create
    @favorite = Favorite.new
    @favorite.user = current_user
    experience = Experience.find(params[:experience_id])
    @favorite.experience = experience
    # params[:github_username] are found only on user show page
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
  end

  def destroy
    @favorite = Favorite.find(params[:id])
    experience = @favorite.experience
    # params[:github_username] are found only on user show page
    if params[:github_username]
      @user = User.find_by(github_username: params[:github_username])
    end
    authorize @favorite
    @favorite.destroy
    respond_to do |format|
      format.html { redirect_to experiences_path }
      format.js
    end
  end
end
