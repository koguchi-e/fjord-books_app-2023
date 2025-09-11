# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update]
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def show; end

  def edit
    if @user == current_user
      render edit_user_registration
    else
      redirect_to users_path
    end
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user)
    else
      redirect_to edit_user_registration
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :post_code, :address, :introduction)
  end
end
