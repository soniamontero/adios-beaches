module NavbarsHelper
  def define_navbar_to_render
    if controller_name == "pages" && action_name == "home"
      return render 'shared/navbar_light'
    elsif controller_name == "registrations" || controller_name == "sessions"
      return render 'shared/navbar_light'
    elsif controller_name == "experiences" && (action_name == "new" || action_name == 'index')
      return render 'shared/navbar_dark'
    elsif controller_name == "experiences" && action_name == "edit"
      return render 'shared/navbar_dark'
    end
  end
end
