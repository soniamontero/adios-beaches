class ExperiencesController < ApplicationController
  def index
    @experiences = policy_scope(Experience)
    # Define experience if there are search or filter queries.
    if params[:category].present?
      @experiences = Experience.joins(:category).where(categories: {name: params[:category]})
      respond_to do |format|
        format.html { redirect_to experiences_path }
        format.js
      end
    elsif params[:query].present?
      if params[:query] == ""
        @experiences = Experience.sorted_by_higher_votes
        respond_to do |format|
          format.html { redirect_to experiences_path }
          format.js
        end
      else
        @experiences = Experience.search_by_name_and_address_and_category(params[:query])
        respond_to do |format|
          format.html { redirect_to experiences_path }
          format.js
        end
      end
      # keyword = params[:query]
      # Experience.where("experiences.title LIKE ? OR experiences.details LIKE ?", "%#{keyword}%", "%#{keyword}%")
    else
      @experiences = Experience.sorted_by_higher_votes
    end

    # Update the placeholder of the search bar depending on serch/filter query
    params_query = (params[:query] == "" || params[:query] == nil) ? false : true
    params_category = (params[:category] == "" || params[:category] == nil) ? false : true
    @params_present = params_query || params_category ? true : false

    if params_query
      @placeholder = params[:query]
    elsif params_category
      @placeholder = params[:category]
    else
      @placeholder = "Search by name / location"
    end

    # Define the markers on the map depending on experiences up there.
    @markers = @experiences.where.not(longitude: nil, latitude: nil).map do |experience|
      {
        lat: experience.latitude,
        lng: experience.longitude,
        infoWindow: render_to_string(partial: "info_window", locals: { experience: experience }),
        id: experience.id
      }
    end
  end

  def show
    @experience = Experience.find(params[:id])
    authorize @experience
    @done = Done.new
    @favorite = Favorite.new
  end

  def new
    @experience = Experience.new
    authorize @experience
  end

  def create
    @experience = Experience.new(experience_params)
    @experience.user = current_user
    authorize @experience
    if @experience.save
      redirect_to experience_path(@experience)
    else
      render :new
    end
  end

  def edit
    @experience = Experience.find(params[:id])
    authorize @experience
  end

  def update
    @experience = Experience.find(params[:id])
    authorize @experience
    if @experience.update(experience_params)
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
