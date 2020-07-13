class SessionsController < ApplicationController
  def new
  end

  def create
    email = params[:session][:email].downcase
    password = params[:session][:password]

    user = User.find_by(email: email)
    if user && user.authenticate(password)
      log_in user
      redirect_to user
    else
      flash.now[:danger] = 'Wrong email or password'
      render 'new'
    end
  end

  def destroy
    logout
    redirect_to login_path
  end
end
