module NavbarsHelper
  def define_navbar_to_render
    if controller_name == "pages" && action_name == "home"
      return render 'shared/navbar_light'
    elsif controller_name == "pages" && action_name == "dashboard"
      return render 'shared/navbar_light_back_btn'
    elsif controller_name == "registrations" && action_name == 'edit'
      return render 'shared/navbar_dark'
    elsif controller_name == "registrations" || controller_name == "sessions"
      return render 'shared/navbar_light'
    elsif controller_name == "experiences" && action_name == "new"
      return render 'shared/navbar_dark'
    elsif controller_name == "experiences" && action_name == "create"
      return render 'shared/navbar_dark'
    elsif controller_name == "experiences" && action_name == "index"
      return render 'shared/navbar_light_back_btn'
    # elsif controller_name == "experiences" && action_name == "show"
    #   return render 'shared/navbar_back_btn'
    elsif controller_name == "experiences" && action_name == "edit"
      return render 'shared/navbar_dark'
    end
  end
end
