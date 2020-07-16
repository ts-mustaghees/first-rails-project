class StaticPagesController < ApplicationController
  def home
    @posts = Post.paginate(page: params[:page], per_page: 12)
    @post = current_user.posts.new
  end

  def timer
  end
end
