class UsersController < ApplicationController
  before_action :check_for_user

  def index
    @users = User.all
  end

  def show
    @user = current_user
    @rules = Rule.where(user: current_user)
    @recipes = Recipe.where(user: current_user)
    @jokes = Joke.where(user: current_user)
    @suggestions = Suggestion.where(archived: false)
    @users = User.all
  end

  def update
    @user = User.friendly.find(params[:id])
    @user.update_attributes(account_update_params)
    if @user.update(account_update_params)
      redirect_to charges_shipping_path
    else
      render :back
      flash[:notice] = "Something is amuck."
    end
  end

  private

  def check_for_user
    unless user_signed_in?
      redirect_to new_user_session_path
    end
  end

  def account_update_params
    params.require(:user).permit(:first_name, :last_name, :manpoints, :email, :password, :password_confirmation, :current_password, :username, :slug, :admin, :stripe_customer_id, :street_address_1, :street_address_2, :city, :state, :zip, :provence, :country)
  end
end
