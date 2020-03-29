class UsersController < ApplicationController
  skip_before_action :redirect, only: [:edit, :update]

  def edit
    @user = current_user
    @lw_cities = LW_CITIES
  end

  def update
    @user = current_user
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
    @my_favorites = @user.favorites
    @my_experiences = @user.experiences
    @my_dones = @user.dones
    @user_experiences_markers = @my_experiences.where.not(longitude: nil, latitude: nil).map do |experience|
      {
        lat: experience.latitude,
        lng: experience.longitude,
        infoWindow: render_to_string(partial: "info_window", locals: { experience: experience }),
        image_url: helpers.asset_url('my-exp-pin.svg')
      }
    end
    @user_favorites_markers = @my_favorites.joins(:experience).where.not(experiences: {longitude: nil, latitude: nil}).map do |favorite|
      {
        lat: favorite.experience.latitude,
        lng: favorite.experience.longitude,
        infoWindow: render_to_string(partial: "info_window", locals: { experience: favorite.experience }),
        image_url: helpers.asset_url('favorite-pin.svg')
      }
    end
    @user_dones_markers = @my_dones.joins(:experience).where.not(experiences: {longitude: nil, latitude: nil}).map do |done|
      {
        lat: done.experience.latitude,
        lng: done.experience.longitude,
        infoWindow: render_to_string(partial: "info_window", locals: { experience: done.experience }),
        image_url: helpers.asset_url('done-pin.svg')
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
  ]

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
