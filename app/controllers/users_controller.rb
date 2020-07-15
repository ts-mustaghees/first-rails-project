class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy
  rescue_from ActiveRecord::RecordNotFound, with: :show_errors

  # GET /users
  # GET /users.json
  def index
    @users = User.where(activated: true).paginate(page: params[:page], per_page: 10)
  end

  # GET /users/1
  # GET /users/1.json
  def show
    redirect_to root_url and return unless @user.activated?
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        @user.send_activation_email
        flash[:info] = "#{@user.name}, please check your email for account activation link."
        format.html { redirect_to root_url }
        #format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        #format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update_attributes(user_params)
        if current_user.admin?
          flash[:success] = "#{@user.name}'s profile was successfully updated."
        else
          flash[:success] = "Your profile was successfully updated."
        end
        format.html { redirect_to @user }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    user = User.find(params[:id]).destroy
    respond_to do |format|
      flash[:success] = "#{user.name} was successfully destroyed."
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    def show_errors
      flash[:error] = "User not found"
      redirect_to root_path
    end

    def logged_in_user
      unless logged_in?
        store_location 
        flash[:danger] = "Please login first."
        redirect_to login_url
      end 
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to root_url unless current_user?(@user) || admin_user
    end

    def admin_user
      if !current_user.admin?
        flash[:danger] = "Unauthorized to perform deletion."
        redirect_to users_path
      end

      true
    end
end
