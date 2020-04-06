class ExperiencesController < ApplicationController
  def index
    @user = current_user
    # Define experience if there are search or filter queries.
    if params[:category].present?
      @experiences = policy_scope(Experience).joins(:category).where(categories: {name: params[:category]})
      respond_to do |format|
        format.html { redirect_to experiences_path }
        format.js
      end
    elsif params[:home_query].present?
      @experiences = policy_scope(Experience).search_by_name_and_address_and_category(params[:home_query])
    elsif params[:query].present?
      if params[:query] == ""
        @experiences = policy_scope(Experience).sorted_by_higher_votes
        respond_to do |format|
          format.html { redirect_to experiences_path }
          format.js
        end
      else
        @experiences = policy_scope(Experience).search_by_name_and_address_and_category(params[:query])
        respond_to do |format|
          format.html { redirect_to experiences_path }
          format.js
        end
      end
      # keyword = params[:query]
      # Experience.where("experiences.title LIKE ? OR experiences.details LIKE ?", "%#{keyword}%", "%#{keyword}%")
    else
      @experiences = policy_scope(Experience).sorted_by_higher_votes
    end

    # Update the placeholder of the search bar depending on serch/filter query
    params_home_query = (params[:home_query] == "" || params[:home_query] == nil) ? false : true
    params_query = (params[:query] == "" || params[:query] == nil) ? false : true
    params_category = (params[:category] == "" || params[:category] == nil) ? false : true
    @params_present = params_query || params_category ? true : false

    if params_query
      @placeholder = params[:query]
    elsif params_home_query
      @placeholder = params[:home_query]
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
    create_params = experience_params
    create_params[:price_range] = convert_to_price_range(create_params)
    @experience = Experience.new(create_params)
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
    update_params = experience_params
    update_params[:price_range] = convert_to_price_range(update_params)
    if @experience.update(update_params)
      redirect_to experience_path(@experience)
    else
      render :edit
    end
  end

  def delete
  end

  def convert_to_price_range(params)
    if params[:price_range] === '€'
      'low'
    elsif params[:price_range] === '€€'
      'medium'
    elsif params[:price_range] === '€€€'
      'high'
    end
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
