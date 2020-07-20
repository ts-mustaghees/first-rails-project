class PostsController < ApplicationController
  before_action :set_post, only: [:update, :destroy]
  before_action :logged_in_user, only: [:create, :update, :destroy]
  before_action :correct_user, only: [:update, :destroy]

  # Note: This better be done through AJAX
  def create
    @post = current_user.posts.build(post_params)

    respond_to do |format|
      if @post.save
        flash[:success] = "#{@post.title} was successfully published."
        format.html { redirect_to request.referrer || root_url }
        format.json { render root_url, status: :created, location: @post }
      else
        @feed = current_user.feed.paginate(page: params[:page], per_page: 10)
        format.html { render 'static_pages/home' } # redirect_to root_url
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @post.destroy
    flash[:success] = "#{@post.title} got deleted successfully."
    redirect_to request.referrer || root_url
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :body, :picture)
  end

  def correct_user
    if !current_user.admin?
      @post = current_user.posts.find_by(id: params[:id])
      redirect_to root_url if @post.nil?
    end
  end
end
