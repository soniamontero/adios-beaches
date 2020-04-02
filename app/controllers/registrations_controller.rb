class RegistrationsController < Devise::RegistrationsController

  def edit
    @lw_cities = LW_CITIES
    super
  end

  def update
    if current_user.update(account_update_params) && current_user.first_login == false
      redirect_to user_profile_path(current_user.github_username)
    else
      super
    end
  end

  def destroy
    if Favorite.where(experience: current_user.experiences).empty? && Done.where(experience: current_user.experiences).empty?
      super
    else
      flash[:notice] = "At least one of your experiences has been saved by another user. You can't delete your account. You are stuck here forever (or you can contact the admin)."
      redirect_back fallback_location: edit_profile_path
    end
  end

  protected

  def update_resource(resource, params)
    resource.update_without_password(params)
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
end
