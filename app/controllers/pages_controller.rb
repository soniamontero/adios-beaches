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
  end
end
