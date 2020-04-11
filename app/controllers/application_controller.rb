class ApplicationController < ActionController::Base
  before_action :store_back_paths
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :redirect
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  include Pundit

  # Pundit: white-list approach.
  after_action :verify_authorized, except: :index, unless: :skip_pundit?
  after_action :verify_policy_scoped, only: :index, unless: :skip_pundit?

  # Uncomment when you *really understand* Pundit!
  # rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  # def user_not_authorized
  #   flash[:alert] = "You are not authorized to perform this action."
  #   redirect_to(root_path)
  # end

  # def user_not_authorized(exception)
  #   if exception.query == 'destroy?' && exception.policy.class.to_s.underscore == 'done_policy'
  #     flash[:error] = exception.policy.try(:error_message) || "Default error message"
  #     byebug
  #   end
  # end

  # Force the user to stay on edit_profile if profile info not completed
  def redirect
    if (current_user && (current_user.first_login || current_user.batch_location.nil?)) && (action_name != "home" && (controller_name != 'sessions' && action_name != 'destroy'))
      flash[:notice] = 'We need these information before letting you access the platform' if current_user && current_user.first_login
      redirect_to edit_profile_path if controller_name != 'users' || action_name != "edit"
    end
  end

  # Devise: after first sign in, go edit
  def after_sign_in_path_for(resource)
    stored_location_for(resource) ||
      if resource.is_a?(User) && resource.first_login || resource.batch_location.nil?
        edit_profile_path
      else
        super
      end
  end

  def configure_permitted_parameters
    # For additional fields in app/views/devise/registrations/new.html.erb
    devise_parameter_sanitizer.permit(:sign_up, keys:
      [:first_name, :github_username, :batch_number, :batch_location, :country, :visited_bali, :slack_username]
    )

    # For additional in app/views/devise/registrations/edit.html.erb
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :batch_number, :batch_location, :country, :visited_bali, :slack_username])
  end

  def store_back_paths
    session[:back_path] ||= [root_path, root_path]
    if request.referer
      session[:back_path] << request.referer unless (request.referer.include?("edit") || request.referer.include?("new"))
    end
    session[:back_path].shift while session[:back_path].count > 5
  end

  private

  def skip_pundit?
    devise_controller? || params[:controller] =~ /(^(rails_)?admin)|(^pages$)/
  end
end
