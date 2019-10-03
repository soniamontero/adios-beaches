class UsersController < ApplicationController
  def edit
    @user = current_user
  end

  def update
    @user = current_user
  end

  private

  def user_params
    params.require(:user).permit(
      :batch_number,
      :batch_location,
      :slack_username,
      :visited_bali
    )
  end
end
