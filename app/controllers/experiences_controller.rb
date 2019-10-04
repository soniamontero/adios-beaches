class ExperiencesController < ApplicationController
  def index
    if params[:category].present?
      @experiences = Experience.joins(:category).where(categories: {name: params[:category]})
    else
      @experiences = Experience.all
    end
  end

  def show
    @experience = Experience.find(params[:id])
    @done = Done.new
    @favorite = Favorite.new
  end

  def new
    @experience = Experience.new
  end

  def create
    @experience = Experience.new(experience_params)
    @experience.user = current_user
    if @experience.save
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
  end

  def update
  end

  def delete
  end

  private

  def experience_params
    params.require(:experience).permit(
      :name,
      :address,
      :price,
      :details,
      :category_id
    )
  end
end
