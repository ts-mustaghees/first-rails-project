class PostsController < ApplicationController
  before_action :set_post, only: [:update, :destroy]
  before_action :logged_in_user, only: [:create, :update, :destroy]

  def create
    @post = current_user.posts.build(post_params)

    respond_to do |format|
      if @post.save
        flash[:success] = "#{@post.title} was successfully published."
        format.html { redirect_to root_url }
        format.json { render root_url, status: :created, location: @post }
      else
        format.html { render 'static_pages/home' }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy

  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :body)
  end
end
