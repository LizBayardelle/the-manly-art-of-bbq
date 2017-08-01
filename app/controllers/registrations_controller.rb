class RegistrationsController < Devise::RegistrationsController
#  before_create :set_username

  private
  def set_username
    @users = User.where(first_name == self.first_name)
    same_first_name_array = []
    @users.each do |u|
      same_first_name_array << u.first_name
    end

    if same_first_name_array.size = 0
      self.username = first_name
    else
      self.username = first_name + " the " + ordinalize(same_first_name_array.size + 1)
    end
  end

  def sign_up_params
    params.require(:user).permit(:first_name, :last_name, :manpoints, :admin, :email, :password, :password_confirmation, :username)
  end

  def account_update_params
    params.require(:user).permit(:first_name, :last_name, :manpoints, :admin, :email, :password, :password_confirmation, :current_password, :username)
  end
end
