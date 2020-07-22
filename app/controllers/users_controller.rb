class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  before_action :authenticate_user!, only: [:index, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy
  rescue_from ActiveRecord::RecordNotFound, with: :show_errors

  # GET /users
  # GET /users.json
  def index
    @users = User.where('confirmed_at IS NOT NULL').paginate(page: params[:page], per_page: 10)
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @posts     = @user.posts.paginate(page: params[:page], per_page: 10).includes([:comments])
    @comments  = @user.comments
    @following = @user.following.paginate(page: params[:following_page], per_page: 10)
    @followers = @user.followers.paginate(page: params[:followers_page], per_page: 10)
    redirect_to root_url and return unless @user.confirmed?
  end

  # GET /users/1/edit
  def edit
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

    def correct_user
      @user = User.find(params[:id])
      redirect_to root_url unless current_user?(@user) || admin_user
    end
end
