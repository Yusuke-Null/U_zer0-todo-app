class ProfilesController < ApplicationController
  before_action :authenticate_user!

  def show
    @profile = current_user.has_profile?
  end

  def edit
  end

  def update
  end

  private
  def profile_params
    params.required(:profile).permit(:nickname, :introduction, :gender, :birthday, :subscribed)
  end
end
