module BackgroundColorsHelper
  def define_background_color
    # God, to simplify.
    if controller_name == "registrations" && action_name == "edit"
      'white-background-color'
    elsif controller_name == 'registrations' && action_name == 'new'
      'login-background-color'
    elsif controller_name == 'sessions'
      'login-background-color'
    elsif controller_name == 'experiences' && action_name == 'index'
      'white-background-color'
    elsif controller_name == 'experiences' && action_name == 'show'
      'white-background-color'
    elsif controller_name == 'pages' && action_name == "home"
      'home-page-background-color'
    elsif controller_name == 'pages' && action_name == "dashboard"
      'dashboard-page-background-color'
    elsif controller_name == 'registrations' && action_name == 'update'
      'white-background-color'
    elsif controller_name == 'users' && action_name == 'show'
      'white-background-color'
    end
  end
end
