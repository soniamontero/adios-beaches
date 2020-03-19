class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :redirect

  def redirect # Force the user to stay on edit_profile if profile info not completed
    redirect_to edit_profile_path if current_user && current_user.first_login
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
      [:github_username, :batch_number, :batch_location, :visited_bali, :slack_username]
    )

    # For additional in app/views/devise/registrations/edit.html.erb
    devise_parameter_sanitizer.permit(:account_update, keys: [:batch_number, :batch_location, :visited_bali, :slack_username])
  end
end
