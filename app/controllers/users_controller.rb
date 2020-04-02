class UsersController < ApplicationController
  skip_before_action :redirect, only: [:edit, :update]

  def edit
    @user = current_user
    authorize @user
    @lw_cities = LW_CITIES
  end

  def update
    @user = current_user
    authorize @user
    if @user.update(user_params) && @user.first_login == true
      @user.first_login = false
      @user.save
      redirect_to root_path
    else
      render action: 'edit'
    end
  end

  def show
    @user = User.find_by(github_username: params[:github_username])
    @user_experiences = @user.experiences
    @my_favorites = @user.favorite_experiences
    @my_dones = @user.done_experiences
    @experiences = @user_experiences
    authorize @user
    if params[:type]
      if params[:type] == "my_experiences"
        @experiences = @user_experiences
      elsif params[:type] == "saved"
        @experiences = @my_favorites
      elsif params[:type] == "dones"
        @experiences = @my_dones
      end
      respond_to do |format|
        format.html { redirect_to user_profile_path(@user.github_username) }
        format.js
      end
    end

    @user_experiences_markers = @user_experiences.where.not(longitude: nil, latitude: nil).map do |experience|
      {
        lat: experience.latitude,
        lng: experience.longitude,
        infoWindow: render_to_string(partial: "info_window", locals: { experience: experience }),
        image_url: helpers.asset_url('my-exp-pin.svg'),
        id: experience.id
      }
    end
    @user_favorites_markers = @my_favorites.where.not(longitude: nil, latitude: nil).map do |experience|
      {
        lat: experience.latitude,
        lng: experience.longitude,
        infoWindow: render_to_string(partial: "info_window", locals: { experience: experience }),
        image_url: helpers.asset_url('favorite-pin.svg'),
        id: experience.id
      }
    end
    @user_dones_markers = @my_dones.where.not(longitude: nil, latitude: nil).map do |experience|
      {
        lat: experience.latitude,
        lng: experience.longitude,
        infoWindow: render_to_string(partial: "info_window", locals: { experience: experience }),
        image_url: helpers.asset_url('done-pin.svg'),
        id: experience.id
      }
    end

    if @user.visited_bali
      @been_to_bali = "Has been to Bali"
    else
      @been_to_bali = "Hasn't visited Bali yet!"
    end
    @same_batch_users = User.where(batch_number: @user.batch_number)

  end

  LW_CITIES = [
    "Bordeaux",
    "Lille",
    "Lyon",
    "Marseille",
    "Nantes",
    "Paris",
    "Rennes",
    "Amsterdam",
    "Barcelona",
    "Berlin",
    "Brussels",
    "Copenhagen",
    "Lausanne",
    "Lisbon",
    "London",
    "Madrid",
    "Milan",
    "Oslo",
    "Rome",
    "Bali",
    "Chengdu",
    "Kyoto",
    "Melbourne",
    "Shanghai",
    "Shenzhen",
    "Singapore",
    "Tokyo",
    "Belo horizonte",
    "Buenos aires",
    "Mexico",
    "Montreal",
    "Rio de janeiro",
    "São paulo",
    "Casablanca",
    "Tel aviv"
  ].sort!

  private

  def user_params
    params.require(:user).permit(
      :batch_number,
      :batch_location,
      :slack_username,
      :visited_bali,
      :country
    )
  end
end
