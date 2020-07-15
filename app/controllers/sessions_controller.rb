class SessionsController < ApplicationController
  def new
  end

  def create
    email = params[:session][:email].downcase
    password = params[:session][:password]

    @user = User.find_by(email: email)
    if @user && @user.authenticate(password)
      if @user.activated?
        log_in @user
        params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
        redirect_back_or @user
      else
        msg = "Account not activated. Check your email for activation link."
        flash[:warning] = msg
        redirect_to root_url
      end
    else
      flash.now[:danger] = 'Wrong email or password'
      render 'new'
    end
  end

  def destroy
    logout if logged_in?
    redirect_to login_path
  end
end
