class DonesController < ApplicationController
  def create
    @done = Done.new
    @done.user = current_user
    experience = Experience.find(params[:experience_id])
    @done.experience = experience
    # TODO: AJAX
    if @done.save && params[:redirect_to] == "index"
      redirect_to experiences_path
    elsif @done.save && params[:redirect_to] == 'show'
      redirect_to experience_path(experience)
    else
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    @done = Done.find(params[:id])
    experience = @done.experience
    @done.destroy
    if params[:redirect_to] == 'show'
      redirect_to experience_path(experience)
    else
      redirect_to experiences_path
    end
  end

  private

  # def done_params
  #   params.require(:done).permit(:user_id, :redirect_to)
  # end
end
