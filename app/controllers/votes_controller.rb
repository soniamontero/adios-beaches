class VotesController < ApplicationController
  def create
    @vote = Vote.new
    @vote.user = current_user
    @vote.value = params[:value]
    experience = Experience.find(params[:experience_id])
    @vote.experience = experience
    # TODO: AJAX
    if @vote.save && params[:redirect_to] == "index"
      redirect_to experiences_path
    elsif @vote.save && params[:redirect_to] == 'show'
      redirect_to experience_path(experience)
    else
      redirect_back(fallback_location: experiences_path)
    end
  end

  def update
    @vote = Vote.find(params[:id])
    experience = @vote.experience
    if @vote.value == 1
      @vote.value = -1
    elsif @vote.value == -1
      @vote.value = 1
    end
    if @vote.save && params[:redirect_to] == 'show'
      redirect_to experience_path(experience)
    elsif @vote.save && params[:redirect_to] == "index"
      redirect_to experiences_path
    else
      redirect_back(fallback_location: experiences_path)
    end
  end

  def destroy
    @vote = Vote.find(params[:id])
    experience = @vote.experience
    @vote.destroy
    if params[:redirect_to] == 'show'
      redirect_to experience_path(experience)
    elsif @vote.save && params[:redirect_to] == "index"
      redirect_to experiences_path
    else
      redirect_back(fallback_location: experiences_path)
    end
  end
end
