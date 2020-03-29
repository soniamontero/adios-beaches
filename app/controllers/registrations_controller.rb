class RegistrationsController < Devise::RegistrationsController

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

end
