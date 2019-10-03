class UsersController < ApplicationController
  skip_before_action :redirect, only: [:edit, :update]

  def edit
    @user = current_user
    @lw_cities = LW_CITIES
  end

  def update
    @user = current_user
    if @user.update(user_params)
      @user.first_login = false
      @user.save
      redirect_to root_path
    else
      render action: 'edit'
    end
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
      :visited_bali
    )
  end
end
