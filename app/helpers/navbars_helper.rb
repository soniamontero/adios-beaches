module NavbarsHelper
  def define_navbar_to_render
    if controller_name == "pages" && action_name == "home"
      return render 'shared/navbar_light'
    else
      return render 'shared/navbar_dark'
    end
  end
end
