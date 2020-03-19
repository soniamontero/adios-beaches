class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    @canggu_exp = Experience.where('address ilike ?','%canggu%')
    @ubud_exp = Experience.where('address ilike ?','%ubud%')
    @seminyak_exp = Experience.where('address ilike ?','%seminyak%')
    @amed_exp = Experience.where('address ilike ?','%amed%')
    @categories = Category.pluck(:name).uniq.map(&:capitalize)
  end

  def dashboard
    @my_favorites = current_user.favorites
    @my_experiences = current_user.experiences
    @my_dones = current_user.dones
    @user_experiences_markers = @my_experiences.where.not(longitude: nil, latitude: nil).map do |experience|
      {
        lat: experience.latitude,
        lng: experience.longitude,
        infoWindow: render_to_string(partial: "info_window", locals: { experience: experience }),
        image_url: helpers.asset_url('my-exp-pin.svg')
      }
    end
    @user_favorites_markers = @my_favorites.joins(:experience).where.not(experiences: {longitude: nil, latitude: nil}).map do |favorite|
      {
        lat: favorite.experience.latitude,
        lng: favorite.experience.longitude,
        infoWindow: render_to_string(partial: "info_window", locals: { experience: favorite.experience }),
        image_url: helpers.asset_url('favorite-pin.svg')
      }
    end
    @user_dones_markers = @my_dones.joins(:experience).where.not(experiences: {longitude: nil, latitude: nil}).map do |done|
      {
        lat: done.experience.latitude,
        lng: done.experience.longitude,
        infoWindow: render_to_string(partial: "info_window", locals: { experience: done.experience }),
        image_url: helpers.asset_url('done-pin.svg')
      }
    end
  end
end
