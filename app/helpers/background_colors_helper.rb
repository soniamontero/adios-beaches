module BackgroundColorsHelper
  def define_background_color
    if controller_name == 'registrations' || controller_name == 'sessions'
      'login-background-color'
    elsif controller_name == 'experiences' && (action_name == 'new' || action_name = 'index')
      'light-blue-background-color'
    elsif controller_name == 'users' && action_name == 'edit'
      'light-blue-background-color'
    elsif controller_name == 'pages'
      'home-page-background-color'
    end
  end
end
