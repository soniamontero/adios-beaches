module BackgroundColorsHelper
  def define_background_color
    if controller_name == 'registrations' || controller_name == 'sessions'
      'login-background-color'
    elsif controller_name == 'experiences' && action_name == 'new'
      'new-experience-background-color'
    elsif controller_name == 'users' && action_name == 'edit'
      'new-experience-background-color'
    elsif controller_name == 'pages' && action_name == 'home'
      'home-page-background-color'
    end
  end
end
