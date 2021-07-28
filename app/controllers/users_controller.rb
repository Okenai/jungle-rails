class UsersController < ApplicationController
  def new
  end

  def create
    user = User.new(user_params)

    if user.valid?
      user.save
      session[:user_id] = user.id
      redirect_to '/'
    else
      redirect_to signup_path, flash: { error: user.errors.full_messages}
    end

    # if user.save
    #   session[:user_id] = user.id
    #   redirect_to '/'
    # else
    #   redirect_to '/signup'
    # end
  end  
  
  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end

end
