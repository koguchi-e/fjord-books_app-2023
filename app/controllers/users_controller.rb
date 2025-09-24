# frozen_string_literal: true

class UsersController < ApplicationController

  def index
    @users = User.order(created_at: :asc).page(params[:page])
  end

  def show
    @user = User.find(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :post_code, :address, :introduction)
  end
end
