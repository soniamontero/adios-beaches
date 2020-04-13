class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    @categories = Category.pluck(:name).uniq.map(&:capitalize)
  end
end
