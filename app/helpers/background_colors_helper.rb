module BackgroundColorsHelper
  def define_background_color
    if controller_name == 'registrations' || controller_name == 'sessions'
      'login-background-color'
    elsif controller_name == 'experiences' && action_name == 'index'
      'light-green-background-color'
    elsif controller_name == 'experiences' && action_name == 'show'
      'light-grey-background-color'
    elsif controller_name == 'pages' && action_name == "home"
      'home-page-background-color'
    elsif controller_name == 'pages' && action_name == "dashboard"
      'dashboard-page-background-color '
    end
  end
end
