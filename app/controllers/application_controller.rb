class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :redirect

  def redirect # Force the user to stay on edit_profile if profile info not completed
    if (current_user && current_user.first_login) && action_name != "home"
      flash[:notice] = 'We need these information before letting you access the platform' if current_user && current_user.first_login
      redirect_to edit_profile_path if controller_name != 'users' && action_name != "edit"
    end
  end

  def after_sign_in_path_for(resource)
    stored_location_for(resource) ||
      if resource.is_a?(User) && resource.first_login
        edit_profile_path
      else
        super
      end
  end

  def configure_permitted_parameters
    # For additional fields in app/views/devise/registrations/new.html.erb
    devise_parameter_sanitizer.permit(:sign_up, keys:
      [:github_username, :batch_number, :batch_location, :country, :visited_bali, :slack_username]
    )

    # For additional in app/views/devise/registrations/edit.html.erb
    devise_parameter_sanitizer.permit(:account_update, keys: [:batch_number, :batch_location, :country, :visited_bali, :slack_username])
  end
end
