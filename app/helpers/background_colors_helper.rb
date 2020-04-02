module BackgroundColorsHelper
  def define_background_color
    if controller_name == "registrations" && action_name == "edit"
      'white-background-color'
    elsif controller_name == 'registrations' && action_name == 'new'
      'login-background-color'
    elsif controller_name == 'sessions'
      'login-background-color'
    elsif controller_name == 'experiences' && action_name == 'index'
      'light-green-background-color'
    elsif controller_name == 'experiences' && action_name == 'show'
      'white-grey-background-color'
    elsif controller_name == 'pages' && action_name == "home"
      'home-page-background-color'
    elsif controller_name == 'pages' && action_name == "dashboard"
      'dashboard-page-background-color'
    elsif controller_name == 'registrations' && action_name == 'update'
      'white-background-color'
    elsif controller_name == 'users' && action_name == 'show'
      'light-green-background-color'
    end
  end
end
