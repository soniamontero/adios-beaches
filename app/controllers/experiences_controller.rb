class ExperiencesController < ApplicationController
  def index
    if params[:category].present?
      @experiences = Experience.joins(:category).where(categories: {name: params[:category]})
    elsif params[:query].present?
      if params[:query] == ""
        @experiences = Experience.all
      else
        @experiences = Experience.search_by_name_and_address(params[:query])
      end
      # keyword = params[:query]
      # Experience.where("experiences.title LIKE ? OR experiences.details LIKE ?", "%#{keyword}%", "%#{keyword}%")
    else
      @experiences = Experience.all
    end
    @placeholder = params[:query] ? params[:query] : "Search by name / location"
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
      redirect_to experience_path(@experience)
    else
      render :new
    end
  end

  def edit
    @experience = Experience.find(params[:id])
  end

  def update
    @experience = Experience.find(params[:id])
    @experience.update(experience_params)
    if @experience.save
      redirect_to experience_path(@experience)
    else
      render :edit
    end
  end

  def delete
  end

  private

  def experience_params
    params.require(:experience).permit(
      :name,
      :address,
      :price,
      :price_range,
      :details,
      :category_id,
      :photo
    )
  end
end
