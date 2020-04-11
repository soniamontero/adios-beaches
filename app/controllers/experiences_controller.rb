class ExperiencesController < ApplicationController
  def index
    @user = current_user
    # Define experience if there are search or filter queries.
    if params[:category].present?
      @experiences = policy_scope(Experience).joins(experience_categories: :category).where(categories: {name: 'Food'})
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
    @experience = Experience.new(experience_params)
    @experience.user = current_user

    authorize @experience

    categories_array = params[:experience][:selected_categories].first.split(' ')

    @empty_categories = true if categories_array.empty?
    @too_many_categories = true if categories_array.length > 3

    if !@empty_categories && @experience.save
      categories_array.each do |category_name|
        category = Category.find_by(name: category_name)
        ExperienceCategory.create!(experience: @experience, category: category)
      end
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
    categories_array = params[:experience][:selected_categories].first.split(' ')
    @empty_categories = true if categories_array.empty?
    @too_many_categories = true if categories_array.length > 3
    if !@empty_categories && categories_array.length <= 3 && @experience.update(experience_params)
      old_categories = ExperienceCategory.where(experience: @experience)
      new_categories = []

      categories_array.each do |category_name|
        category = Category.find_by(name: category_name)
        new_categories << ExperienceCategory.find_or_create_by!(experience: @experience, category: category)
      end
      # Filter the unselected categories and delete them from db
      cat_to_remove = (old_categories + new_categories - (old_categories & new_categories))

      cat_to_remove.each {|e| e.destroy } unless cat_to_remove.empty?
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
